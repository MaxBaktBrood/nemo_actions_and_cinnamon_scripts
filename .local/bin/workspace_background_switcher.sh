#!/bin/bash
# Script to set a per workspace desktop background in Cinnamon.
# Save as ~/bin/workspace_backgrounds_switcher.sh or ~/.local/bin/workspace_backgrounds_switcher.sh and make executable
# Add an entry in startup applications to launch the script on start-up.

# Set your images here - one per active workspace.
# Add extra WORKSPACE_BACKGROUND[X] entries as necessary.
WORKSPACE_BACKGROUND[0]=""
WORKSPACE_BACKGROUND[1]=""
WORKSPACE_BACKGROUND[2]=""
WORKSPACE_BACKGROUND[3]=""
WORKSPACE_BACKGROUND[4]=""
WORKSPACE_BACKGROUND[5]=""

# Set your themes here - one per active workspace.
# Add extra WORKSPACE_THEME[X] entries as necessary.
WORKSPACE_THEME[0]=""
WORKSPACE_THEME[1]=""
WORKSPACE_THEME[2]=""
WORKSPACE_THEME[3]=""
WORKSPACE_THEME[4]=""
WORKSPACE_THEME[5]=""

# Set your workspace switching sound here - one per active workspace.
# Add extra WORKSPACE_SOUND[X] entries as necessary.
WORKSPACE_SOUND[0]=""
WORKSPACE_SOUND[1]=""
WORKSPACE_SOUND[2]=""
WORKSPACE_SOUND[3]=""
WORKSPACE_SOUND[4]=""
WORKSPACE_SOUND[5]=""

WORKSPACE_STARTBUTTON[0]=""
WORKSPACE_STARTBUTTON[1]=""
WORKSPACE_STARTBUTTON[2]=""
WORKSPACE_STARTBUTTON[3]=""
WORKSPACE_STARTBUTTON[4]=""
WORKSPACE_STARTBUTTON[5]=""

WORKSPACE_STARTTEXT[0]=""
WORKSPACE_STARTTEXT[1]=""
WORKSPACE_STARTTEXT[2]=""
WORKSPACE_STARTTEXT[3]=""
WORKSPACE_STARTTEXT[4]=""
WORKSPACE_STARTTEXT[5]=""

# Main script starts here
# Check for existing instances and kill them leaving current instance running
for PID in $(pidof -o %PPID -x "${0##*/}"); do
    if [ "$PID" != $$ ]; then
        kill -9 "$PID"
    fi 
done
# Monitor for workspace changes and set the background on change.
xprop -root -spy _NET_CURRENT_DESKTOP | while read -r;
  do
    gsettings set org.cinnamon.desktop.background picture-uri "file://${WORKSPACE_BACKGROUND[${REPLY: -1}]}"
    gsettings set org.cinnamon.desktop.interface gtk-theme "${WORKSPACE_THEME[${REPLY: -1}]}"
    gsettings set org.cinnamon.desktop.wm.preferences theme "${WORKSPACE_THEME[${REPLY: -1}]}"
    gsettings set org.cinnamon.theme name "${WORKSPACE_THEME[${REPLY: -1}]}"
    aplay "${WORKSPACE_SOUND[${REPLY: -1}]}"
#    sed "167c\        "value": "${WORKSPACE_STARTBUTTON[${REPLY: -1}]}"" "/home/maxbaktbrood/.cinnamon/configs/CinnVIIStarkMenu@NikoKrause/24.json"
#    sed "176c\                "value": "${WORKSPACE_STARTTEXT[${REPLY: -1}]}"" "/home/maxbaktbrood/.cinnamon/configs/CinnVIIStarkMenu@NikoKrause/24.json"
  done
