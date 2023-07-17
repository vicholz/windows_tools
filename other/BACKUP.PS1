#!/usr/bin/env pwsh

$HOSTNAME = "$env:COMPUTERNAME"
$USERNAME = "$env:USERNAME"
$BACKUP_PATH = "BACKUP\$HOSTNAME\$USERNAME"
$TARGET_DRIVE = $pwd.drive.name
$TARGET_PATH = "${TARGET_DRIVE}:\$BACKUP_PATH"

$SOURCE_FOLDERS = "MyDocuments", "MyPictures", "MyVideos", "MyMusic", "Desktop", "Downloads"

$ROBOCOPY_CONFIG = "/R:3 /W:5 /S /Z /XO /FFT /MT /COMPRESS /ETA"
$ROBOCOPY_EXCLUDES = "/XF '*.gdoc' '*.gsheets' '*.gslides' '*.gdraw'"
$ROBOCOPY_LOG = "/TEE /LOG:backup.log"
$ROBOCOPY_PARAMS = "${ROBOCOPY_CONFIG} ${ROBOCOPY_EXCLUDES} ${ROBOCOPY_LOG}"

function confirm_continue {
    Read-Host -Prompt "Press ENTER to continue or press CTRL+C, or close this window to exit"
}

function confirm_exit {
    Read-Host -Prompt "Press ENTER, CTRL+C, or close this window to exit"
    exit 0
}

function abort {
    Write-Output "ABORTED!"
    confirm_exit
}

function get_folder_path {
    Param([string]$folder)
    if ($folder -eq "Downloads") {
       return (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    } else {
        return [Environment]::GetFolderPath($folder)
    }
}

function rcopy {
    Param([string]$source, [string]$target)
    Write-Output "Copying '$source' to '$target'..."
    try {
        Invoke-Expression "robocopy ${source} ${target} ${ROBOCOPY_PARAMS}"
        Write-Output "Copying '$source' to '$target'...DONE!"
    } catch {
        Write-Output "Failed to copy '$source' to '$target':"
        Write-Output $_.Exception
        Write-Output "Copying '$source' to '$target'...FAILED!"
    }
}

function backup {
    Param([array]$folder_list)

    foreach($folder in $folder_list) {
        rcopy "$(get_folder_path $folder)" "$TARGET_PATH\$folder"
        Write-Output ""
    }
}

Write-Output "################ BACKUP TOOL ################"
Write-Output "This tool will backup the following folders:"
foreach($folder in $SOURCE_FOLDERS) {
    Write-Output "$(get_folder_path $folder) -> $TARGET_PATH\$folder"
}
Write-Output ""
confirm_continue
Write-Output ""
Write-Output "Starting backup..."
backup $SOURCE_FOLDERS
exit 0
