#!/bin/bash
# A utilities script that aids in the editing of SMITE setting without being in game.
# Date : (2015-10-08)
# Last revision : (2015-10-08 3:50)
# Licence : GPLv3
# Author : Rolando Islas

SETTING_PATH="$HOME/Documents/My Games/Smite/BattleGame/Config/BattleSystemSettings.ini"
RESULT="\n"

clear
echo -e "This script will aid in the editing of SMITE's settings.\n"

function setFullscreen {
	RESULT="$RESULT fullscreen: $1\n"
	sed -i '' -E "s/Fullscreen=.*/Fullscreen=$1/" "$SETTING_PATH"
}

function setBorderless {
	RESULT="$RESULT borderless: $1\n"
	sed -i '' -E "s/Borderless=.*/Borderless=$1/" "$SETTING_PATH"
}

function setResolution {
	RESULT="$RESULT resolution: $1 $2\n"
	sed -i '' -E "s/ResX=.*/ResX=$1/" "$SETTING_PATH"
	sed -i '' -E "s/ResY=.*/ResY=$2/" "$SETTING_PATH"
}

function run {
	echo -e "Settings found at '$SETTING_PATH'.\n"
	
	echo "Enable fullscreen?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) setFullscreen true; fullscreen=true; break;;
			No ) setFullscreen false; fullscreen=false; break;;
		esac
	done
	
	if [[ $fullscreen = false ]]; then
		echo "Enable borderess window?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) setBorderless true; break;;
				No ) setBorderless false; break;;
			esac
		done
	fi
	
	read res <<<$(system_profiler SPDisplaysDataType | grep Resolution | grep -oE -m1 '[0-9]{3,}')
	echo "Suggested resolution: $res"
	
	read -p "Enter desired X resolution: " x
	read -p "Enter desired Y resolution: " y
	if [[ -n $x ]] && [[ -n $y ]]; then
		setResolution $x $y
	fi
	
	echo "The follwoing settings have been applied:"
	echo -e $RESULT
}

if [[ -f "$SETTING_PATH" ]]; then
	run
else
	echo -e "Settings not found in '$SETTING_PATH'.\nLaunch SMITE at least once to generate the file."
fi
