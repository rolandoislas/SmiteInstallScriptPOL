Smite Install Script - PlayOnLinux/PlayOnMac
---

See [Translator5/PlayOnLinux-InstallScripts](https://github.com/Translator5/PlayOnLinux-InstallScripts) for an updated install script.

This is a mostly automated script for [PlayOnMac/PlayOnLinux] that will install [Smite].

## Install

* Be sure to have [PlayOnMac/PlayOnLinux] installed.
* From the `Tools` menu choose `Run a Local Script` and select [`Smite.sh`](./Smite.sh).
* Follow the install instructions.

###### Launcher Update Loop
The launcher seems to need access to the terminal for it to properly update. The script ensure that the `TERM` environmental variable is set.

During the install you will be prompted for the system terminal (xterm default). If you are unsure of your current terminal go with the default and install xterm before launching Smite. Others, such as gnome-terminal, have been tested and failied to operate properly. This results in the launcher not being able to update.

###### Note: The auto-download is unreliable due to the installer executable/checksum changing occasionally. It is recommended to download the [installer] separately and choose to install via the local option.

## Post-Install

###### Black-Screen Issue
This issue can be fixed by running the game in windowed or borderless window mode. You can edit the following file to change the settings:

```
~/Documents/My\ Games/Smite/BattleGame/Config/BattleSystemSettings.ini
```

(This is the directory on OS X. Please create an issue if this is different on Linux.)

Look for the `Fullscreen` line and set it false. `Borderless` can also be set to `true` here.

OS X users can use [`Mac Resolution Edit.command`](./Mac%20Resolution%20Edit.command) to edit the file. Launch the game at least once before attempting to run the script.

[PlayOnMac/PlayOnLinux]: https://www.playonlinux.com
[Smite]: http://www.smitegame.com
[installer]: http://hirez.http.internapcdn.net/hirez/InstallSmite.exe
