#!/usr/bin/env playonlinux-bash
# A PlayOnLinux/Mac install script for SMITE.
# Date : (2015-08-18)
# Last revision : (2016-03-30 01:11)
# Wine version used : 1.9.3
# Distribution used to test : Ubuntu 15.10 64 bit
# Licence : GPLv3
# Author : Rolando Islas

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SMITE"
PREFIX="Smite"
WINEVERSION="1.9.3"
DEFAULT_TERM="xterm"
 
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Hi-Rez Studios" "http://www.smitegame.com/" "Rolando Islas" "Smite"

POL_SetupWindow_InstallMethod "STEAM,DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
	FULL_INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
	POL_System_TmpCreate "$PREFIX"
 
	DOWNLOAD_URL="http://hirez.http.internapcdn.net/hirez/InstallSmite.exe"
	DOWNLOAD_MD5="5b7e0574a48b2550561d8bd8121e92a1"
	DOWNLOAD_FILE="$POL_System_TmpDir/$(basename "$DOWNLOAD_URL")"
 
	POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$DOWNLOAD_MD5" "$TITLE installer"
 
	FULL_INSTALLER="$DOWNLOAD_FILE"
fi

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

if [ "$POL_OS" = "Linux" ]; then
	POL_SetupWindow_textbox "System terminal (Leave blank to use $DEFAULT_TERM): " "$TITLE"
	if [ "$APP_ANSWER" != "" ]; then
		DEFAULT_TERM=$APP_ANSWER
	fi
	POL_Call POL_Function_RootCommand "echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope; exit"
fi

POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_directx9
POL_Call POL_Install_dotnet35sp1
POL_Call POL_Install_dotnet40
POL_Call POL_Install_gdiplus
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_xact

Set_OS "win7"

if [ "$INSTALL_METHOD" = "STEAM" ]; then
	POL_Call POL_Install_steam
	POL_SetupWindow_message "Install $TITLE within Steam.\n\nClick next once installed." "$TITLE"
	POL_Shortcut "Steam.exe" "Steam"
	POL_Shortcut_InsertBeforeWine "Steam" "export TERM=$DEFAULT_TERM"
else
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$FULL_INSTALLER"
	POL_Shortcut "HiRezLauncherUI.exe" "$TITLE" "" "game=300 product=17"
	POL_Shortcut_InsertBeforeWine "$TITLE" "export TERM=$DEFAULT_TERM"
fi

Set_OS "winxp"
POL_Call POL_Function_OverrideDLL builtin,native dnsapi

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
	POL_System_TmpDelete
fi

POL_SetupWindow_Close
exit

