@ECHO OFF

echo "Importing Registry Configs..."
reg import clock_show_seconds.reg
reg import disable_lock_screen.reg
reg import HKCUCSB_folder_settings.reg
reg import HKCUSB_folder_settings.reg
reg import lockscreen_disable_background.reg
echo "Importing Registry Configs...DONE!"
echo
echo "Copying ls/ll command shortcuts..."
copy /y ls.cmd c:\windows\
copy /y ll.cmd c:\windows\
echo "Copying ls/ll command shortcuts...DONE!"
echo
echo "DONE!"
pause
exit
