#!/usr/bin/env pwsh

#$SOURCE_DRIVE = "c:"
$SOURCE_DRIVE = "d:"
$TARGET_DRIVE = $pwd.drive.name
$FOLDER_PATH = ""
#$FOLDER_PATH = $HOME
$FOLDERS = "desktop", "documents", "music", "pictures", "videos"

$ROBOCOPY_PARAMS = "/R:10 /S /Z /XO /FFT"

function do_copy {
    Param([string]$source, [string]$target)
    Write-Output "Copying '$source' to '$target'..."
    & "robocopy $source $target $ROBOCOPY_PARAMS"
    Write-Output "Copying '$source' to '$target'...DONE!"
}

function backup {
    Param([array]$folder_list)

    foreach($folder in $folder_list) {
        do_copy "$SOURCE_DRIVE\$FOLDER_PATH\$folder" "$TARGET_DRIVE\$FOLDER_PATH\$folder"
    }
}

function check_source_target {
    Param([string]$source, [string]$target)
    if ($source.ToLower() -eq $target.ToLower()) {
        Write-Output "ERROR: The source and target drives are the same. Please update this script or re-run it from the backup drive."
        exit 1
    }
}

check_source_target $SOURCE_DRIVE $TARGET_DRIVE
Write-Output "################ BACKUP TOOL ################"
Write-Output "This tool will backup the following folders:"
foreach($folder in $FOLDERS) {
    Write-Output "$SOURCE_DRIVE\$FOLDER_PATH\$folder -> $TARGET_DRIVE\$FOLDER_PATH\$folder"
}
Write-Output ""
Read-Host -Prompt "Press ENTER to continue or CTRL+C/close this window to exit" 
Write-Output ""
Write-Output "Starting backup..."
backup $FOLDERS
exit 0
