@ECHO OFF

set SOURCE_DRIVE=d:
set CURRENT_DRIVE=%CD:~0,2%
set BACKUP_DIRS=documents downloads music pictures videos
set ROBOCOPY_OPTS=/R:10 /S /Z /XO /FFT

if %SOURCE_DRIVE% == %CURRENT_DRIVE% (
    echo source drive %SOURCE_DRIVE% is the same as the target drive %CURRENT_DRIVE%.
    echo exiting.
    exit
)

echo ############# BACKUP TOOL #############
echo THIS WILL BACKUP THE FOLLOWING FOLDERS:
for %%a in (%BACKUP_DIRS%) do (
    echo %SOURCE_DRIVE%\%%a to %CURRENT_DRIVE%\%%a
)
echo
echo "CLOSE THIS WINDOW OR PRESS CTRL+C TO CANCEL OR"
pause

for %%a in (%BACKUP_DIRS%) do (
    echo Copying %SOURCE_DRIVE%\%%a to %CURRENT_DRIVE%\%%a...
    robocopy %SOURCE_DRIVE%\%%a %CURRENT_DRIVE%\%%a %ROBOCOPY_OPTS%
    echo Copying %SOURCE_DRIVE%\%%a to %CURRENT_DRIVE%\%%a...DONE!
    echo
)
echo BACKUP IS COMPLETE!
pause
exit