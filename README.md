<h3 align="center">
	Bearded Giant Theme for <a href="https://github.com/tmux/tmux">Tmux</a>
</h3>

<p align="center">
  <img src="./assets/preview.webp"/>
</p>

## Content

1. [Theme](#theme)
2. [Installation](#installation)
3. [Overview](#overview)
4. [Configuration options](#configuration-options)
   1. [Window](#window)
   2. [Window default](#window-default)
   3. [Window current](#window-current)
   4. [Status](#status)
   5. [Customizing modules](#customizing-modules)
   6. [Battery module](#battery-module)
5. [Create a custom module](#create-a-custom-module)
6. [Configuration Examples](#configuration-examples)
   1. [Config 1](#config-1)
   2. [Config 2](#config-2)
   3. [Config 3](#config-3)

## Theme

- 🌿 [Dark](./bearded-giant-dark.tmuxtheme)

## Installation

In order to have the icons displayed correctly please use / update your favorite [patched font](https://www.nerdfonts.com/font-downloads).
If you do not have a patched font installed, you can override or remove any icon. Check the documentation below on the options available.

### TPM

1. Install [TPM](https://github.com/tmux-plugins/tpm)
2. Add the Bearded Giant plugin:

```bash
set -g @plugin 'bearded-giant/tmux'
# ...alongside
set -g @plugin 'tmux-plugins/tpm'
```

### Manual

1. Copy the Dark theme configuration contents into your Tmux config (usually stored at `~/.tmux.conf`)
2. Reload Tmux by either restarting the session or reloading it with `tmux source-file ~/.tmux.conf`

## Overview

![Default](./assets/overview.png)
This is a diagram on how the theme is split between its components.

## Configuration options

The Dark theme supports certain levels of customization. To add these customizations, add any of the following options to your Tmux configuration.

### Window

#### Set the window left separator:
```sh
set -g @bearded_giant_window_left_separator "█"
```

#### Set the window middle separator:
```sh
set -g @bearded_giant_window_middle_separator "█"
```

#### Set the window right separator:
```sh
set -g @bearded_giant_window_right_separator "█"
```

#### Position the number:
```sh
set -g @bearded_giant_window_number_position "left"
```
Values:
- left - the number will be on the left part of the window
- right - the number will be on the right part of the window

#### Enable window status:
```sh
set -g @bearded_giant_window_status_enable "yes"
```
Values:
- yes - this will enable the window status part
- no - this will disable the window status part

#### Enable window status icons instead of text:
```sh
set -g @bearded_giant_window_status_icon_enable "yes"
```
Values:
- yes - this will replace the windows status text with icons
- no - this will keep the windows status in text format

#### Override windows status icons
```sh
set -g @bearded_giant_icon_window_last "󰖰"
set -g @bearded_giant_icon_window_current "󰖯"
set -g @bearded_giant_icon_window_zoom "󰁌"
set -g @bearded_giant_icon_window_mark "󰃀"
set -g @bearded_giant_icon_window_silent "󰂛"
set -g @bearded_giant_icon_window_activity "󰖲"
set -g @bearded_giant_icon_window_bell "󰂞"
```

### Window default

#### Set the window default color fill:
```sh
set -g @bearded_giant_window_default_fill "number"
```
Values:
- number - only the number of the window part will have color
- all - the entire window part will have the same color
- none - the entire window part will have no color

#### Override the window default text:
```sh
set -g @bearded_giant_window_default_text "#{b:pane_current_path}" # use "#W" for application instead of directory
```

### Window current

#### Set the window current color fill:
```sh
set -g @bearded_giant_window_current_fill "number"
```
Values:
- number - only the number of the window part will have color
- all - the entire window part will have the same color
- none - the entire window part will have no color

#### Override the window current text:
```sh
set -g @bearded_giant_window_current_text "#{b:pane_current_path}" # use "#W" for application instead of directory
```

#### Set the current directory format
```sh
set -g @bearded_giant_window_current_format_directory_text "#{b:pane_current_path}"
```
Use this to overide the way the current directory is displayed.

#### Set the directory format
```sh
set -g @bearded_giant_window_format_directory_text "#{b:pane_current_path}"
```
Use this to overide the way the directory is displayed.

### Status

#### Set the status module left separator:
```sh
set -g @bearded_giant_status_left_separator ""
```

#### Set the status module right separator:
```sh
set -g @bearded_giant_status_right_separator "█"
```

#### Set the status module right separator inverse:
```sh
set -g @bearded_giant_status_right_separator_inverse "no"
```
Values:
- yes - the colors will be inverted for the right separator
- no - the colors will not be inverted for the right separator

#### Set the status connect separator:
```sh
set -g @bearded_giant_status_connect_separator "yes"
```
Values:
- yes - the background color of the separator will not blend in with the brackground color of tmux
- no - the background color of the separator will blend in with the brackground color of tmux


#### Set the status module color fill:
```sh
set -g @bearded_giant_status_fill "icon"
```
Values:
- icon - only the icon of the module will have color
- all - the entire module will have the same color

#### Set the module list
```sh
set -g @bearded_giant_status_modules_right "application session"
set -g @bearded_giant_status_modules_left ""
```
Provide a list of modules and the order in which you want them to appear in the status.

Available modules:
- application - display the current window running application
- directory - display the basename of the current window path
- session - display the number of tmux sessions running
- user - display the username
- host - display the hostname
- date_time - display the date and time
- [battery](#battery-module) - display the battery

### Customizing modules

Every module (except the module "session") supports the following overrides:

#### Override the specific module icon
```sh
set -g @bearded_giant_[module_name]_icon "icon"
```

#### Override the specific module color
```sh
set -g @bearded_giant_[module_name]_color "color"
```

#### Override the specific module text
```sh
set -g @bearded_giant_[module_name]_text "text"
```

#### Removing a specific module option
```sh
set -g @bearded_giant_[module_name]_[option] "null"
```
This is for the situation where you want to remove the icon from a module.
Ex:
```sh
set -g @bearded_giant_date_time_icon "null"
```

### Battery module

#### Requirements
This module depends on [tmux-battery](https://github.com/tmux-plugins/tmux-battery/tree/master).

#### Install
The prefered way to install tmux-battery is using [TPM](https://github.com/tmux-plugins/tpm).

#### Configure
Load tmux-battery after you load Bearded Giant theme.
```sh
set -g @plugin 'bearded-giant/tmux'
...
set -g @plugin 'tmux-plugins/tmux-battery'
```

Add the battery module to the status modules list.
```sh
set -g @bearded_giant_status_modules_right "... battery ..."
```

## Create a custom module

It is possible to add a new custom module or overrite any of the existing modules.

Look into custom/README.md for more details.

Any file added to the custom folder will be preserved when updating the theme.

## Configuration Examples
Below are provided a few configurations as examples or starting points.

Note:
When switching between configurations run:
```sh
tmux kill-server
```
In order to kill the tmux server and clear all global variables.


### Config 1
![Default](./assets/config1.png)

```sh
set -g @bearded_giant_window_right_separator "█ "
set -g @bearded_giant_window_number_position "right"
set -g @bearded_giant_window_middle_separator " | "

set -g @bearded_giant_window_default_fill "none"

set -g @bearded_giant_window_current_fill "all"

set -g @bearded_giant_status_modules_right "application session user host date_time"
set -g @bearded_giant_status_left_separator "█"
set -g @bearded_giant_status_right_separator "█"

set -g @bearded_giant_date_time_text "%Y-%m-%d %H:%M:%S"
```

### Config 2
![Default](./assets/config2.png)

```sh
set -g @bearded_giant_window_left_separator "█"
set -g @bearded_giant_window_right_separator "█ "
set -g @bearded_giant_window_number_position "right"
set -g @bearded_giant_window_middle_separator "  █"

set -g @bearded_giant_window_default_fill "number"

set -g @bearded_giant_window_current_fill "number"
set -g @bearded_giant_window_current_text "#{pane_current_path}"

set -g @bearded_giant_status_modules_right "application session date_time"
set -g @bearded_giant_status_left_separator  ""
set -g @bearded_giant_status_right_separator " "
set -g @bearded_giant_status_right_separator_inverse "yes"
set -g @bearded_giant_status_fill "all"
set -g @bearded_giant_status_connect_separator "no"
```

### Config 3
![Default](./assets/config3.png)

```sh
set -g @bearded_giant_window_left_separator ""
set -g @bearded_giant_window_right_separator " "
set -g @bearded_giant_window_middle_separator " █"
set -g @bearded_giant_window_number_position "right"

set -g @bearded_giant_window_default_fill "number"
set -g @bearded_giant_window_default_text "#W"

set -g @bearded_giant_window_current_fill "number"
set -g @bearded_giant_window_current_text "#W"

set -g @bearded_giant_status_modules_right "directory user host session"
set -g @bearded_giant_status_left_separator  " "
set -g @bearded_giant_status_right_separator ""
set -g @bearded_giant_status_right_separator_inverse "no"
set -g @bearded_giant_status_fill "icon"
set -g @bearded_giant_status_connect_separator "no"

set -g @bearded_giant_directory_text "#{pane_current_path}"
```

## License

MIT License

Copyright (c) 2023-present