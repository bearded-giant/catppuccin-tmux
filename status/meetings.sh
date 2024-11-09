#!/bin/bash

ALERT_IF_IN_NEXT_MINUTES=180
ALERT_POPUP_BEFORE_SECONDS=60
NERD_FONT_FREE="󱁕 "
NERD_FONT_MEETING="󰤙"

get_attendees() {
  attendees=$(
    icalBuddy \
      --includeEventProps "attendees" \
      --propertyOrder "datetime,title" \
      --noCalendarNames \
      --dateFormat "%A" \
      --includeOnlyEventsFromNowOn \
      --limitItems 1 \
      --excludeAllDayEvents \
      --separateByDate \
      --excludeEndDates \
      --bullet "" \
      --excludeCals "" \
      eventsToday
  )
}

parse_attendees() {
  attendees_array=()
  for line in $attendees; do
    attendees_array+=("$line")
  done
  number_of_attendees=$((${#attendees_array[@]} - 3))
}

get_next_meeting() {
  next_meeting=$(icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%I:%M %p" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    --excludeCals "" \
    eventsToday)
  # echo "Next meeting output: $next_meeting"
}

parse_result() {
  array=()
  while IFS= read -r line; do
    # Skip lines with "today:" and separator lines
    [[ "$line" == "today:" || "$line" == "------------------------" ]] && continue
    array+=("$line")
  done <<<"$1"

  # Extract time range and title from remaining lines
  if [[ ${#array[@]} -ge 2 ]]; then
    time_range="${array[0]}"
    title="${array[1]}"

    # Split time range into start and end times
    time=$(echo "$time_range" | awk -F ' - ' '{print $1}')
    end_time=$(echo "$time_range" | awk -F ' - ' '{print $2}')
  else
    echo "Error: Unexpected event data format."
    exit 1
  fi

  echo "Parsed time: $time"
  echo "Parsed end time: $end_time"
  echo "Parsed title: $title"
}

calculate_times() {
  # Remove any non-standard whitespace characters in the time string
  time=$(echo "$time" | sed 's/ / /g')
  epoc_meeting=$(date -j -f "%I:%M %p" "$time" +%s 2>/dev/null)
  if [[ -z $epoc_meeting ]]; then
    echo "Error: Failed to parse meeting time. Check the format."
    exit 1
  fi

  epoc_now=$(date +%s)
  epoc_diff=$((epoc_meeting - epoc_now))
  minutes_till_meeting=$((epoc_diff / 60))
}

display_popup() {
  tmux display-popup \
    -S "fg=#eba0ac" \
    -w50% \
    -h50% \
    -d '#{pane_current_path}' \
    -T meeting \
    icalBuddy \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --formatOutput \
    --includeEventProps "title,datetime,notes,url,attendees" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --excludeCals "training" \
    eventsToday
}

print_tmux_status() {
  # Check if there is an upcoming meeting within the alert window
  if [[ $minutes_till_meeting -lt $ALERT_IF_IN_NEXT_MINUTES &&
    $minutes_till_meeting -gt -60 ]]; then
    echo "$NERD_FONT_MEETING $time $title ($minutes_till_meeting minutes)"
  else
    echo "$NERD_FONT_FREE"
  fi

  # Show popup if within the alert window
  if [[ $epoc_diff -gt $ALERT_POPUP_BEFORE_SECONDS &&
    $epoc_diff -lt $((ALERT_POPUP_BEFORE_SECONDS + 10)) ]]; then
    display_popup
  fi
}

main() {
  get_attendees
  parse_attendees
  get_next_meeting

  # Check if next_meeting has content
  if [[ -z $next_meeting ]]; then
    echo "$NERD_FONT_FREE No upcoming meetings."
    exit 0 # Exit gracefully if no meeting is found
  fi

  parse_result "$next_meeting"
  calculate_times
  print_tmux_status
}

main
