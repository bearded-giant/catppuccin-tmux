show_meetings() {
  local index=$1
  local icon
  local color
  local result
  local text
  local module

  icon="$(get_tmux_option "@catppuccin_meetings_icon" "󰤙")"

  result="$($HOME/.config/tmux/scripts/cal.sh)"

  meeting_color=$(echo "$result" | cut -d'|' -f1)
  meeting_text=$(echo "$result" | cut -d'|' -f2-)

  case "$meeting_color" in
  "blue") color="$thm_blue" ;;
  "yellow") color="$thm_yellow" ;;
  "orange") color="$thm_peach" ;;
  "red") color="$thm_red" ;;
  *) color="$thm_blue" ;; # fallback
  esac

  text="$meeting_text"

  module=$(build_status_module "$index" "$icon" "$color" "$text")

  echo "$module"
}
