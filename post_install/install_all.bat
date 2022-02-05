@ECHO OFF

echo "Importing Registry Configs..."
reg import post_install/clock_show_seconds.reg
reg import post_install/disable_lock_screen.reg
reg import post_install/HKCUCSB_folder_settings.reg
reg import post_install/HKCUSB_folder_settings.reg
reg import post_install/lockscreen_disable_background.reg
echo "Importing Registry Configs...DONE!"
echo
echo "Copying ls/ll command shortcuts..."
copy /y ls.cmd c:\windows\
copy /y ll.cmd c:\windows\
echo "Copying ls/ll command shortcuts...DONE!"
exit
