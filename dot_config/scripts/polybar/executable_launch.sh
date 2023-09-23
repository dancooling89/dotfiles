#!/usr/bin/env

# Source the theme environment variables
source $HOME/.config/scripts/themes/catppuccin.sh

# Terminate already running bar instances
# If all your bars have ipc enabled, use
polybar-msg cmd quit

# Otherwise use the nuclear option
# killall -q polybar

# Labels for use in polybar
# Mount point label
export LABEL_MOUNT="%{F$THEME_MAUVE}%mountpoint%%{F-} %percentage_used%%"

# Network interface labels
export LABEL_IF_DISCONNECTED="%{F$THEME_MAUVE}%ifname%%{F$THEME_RED} disconnected"
export LABEL_IF_CONNECTED="%{F$THEME_MAUVE}%ifname%%{F-} %local_ip%"

# Apply to all monitors
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload dcbar &
	done
else
	polybar --reload dcbar &
fi

echo "Bars launched..."
