@ECHO OFF
echo.
echo Importing Registry Configs...
reg import change_shell_shortcut_to_z_drive.reg
reg import change_user_shell_shortcut_to_z_drive.reg
echo Importing Registry Configs...DONE!
echo.
echo DONE!
echo.
echo Press ENTER to reboot the machine or close this window to continue working.
pause
shutdown /r /f /now
