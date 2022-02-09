@ECHO OFF
echo.
echo Importing Registry Configs...
reg import clock_show_seconds.reg
reg import lockscreen_disable.reg
reg import HKCUCSB_folder_settings.reg
reg import HKCUSB_folder_settings.reg
reg import uac_enable.reg
echo Importing Registry Configs...DONE!
echo.
echo Copying ls/ll command shortcuts...
copy /y ls.cmd c:\windows\
copy /y ll.cmd c:\windows\
echo Copying ls/ll command shortcuts...DONE!
echo.
echo DONE!
echo.
echo Press ENTER to reboot the machine or close this window to continue working.
pause
shutdown /r /f /now
