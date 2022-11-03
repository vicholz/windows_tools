#!/usr/bin/env pwsh

$TARGET_FILE = "backup_target.txt"
$TARGET_PATH = Get-Content $TARGET_FILE
$TARGET_PATH | Select-Object -Last 1

if (!(Test-Path -Path $TARGET_FILE -PathType Leaf) -or !($TARGET_PATH)){
    Write-Output "ERROR! File 'backup_target.txt' was not found or was empty."
    Write-Output "Please make sure 'backup_target.txt' exists and contains one line with a target path."
    Read-Host -Prompt "Press ENTER or CTRL+C/close this window to exit" 
    exit 0 
}

$SOURCE_PATH = Get-Location
$SOURCE_DIR_NAME = Split-Path -Path (Get-Location) -Leaf

$TARGET_PATH = "$TARGET_PATH\$SOURCE_DIR_NAME"

$ROBOCOPY_PARAMS = "/R:10 /W:10 /S /Z /XO /FFT /MT"

function do_copy {
    Param([string]$source, [string]$target)
    Write-Output "Copying '$source' to '$target'..."
    "robocopy '$source' '$target' $ROBOCOPY_PARAMS" | Invoke-Expression
    Write-Output "Copying '$source' to '$target'...DONE!"
}

Write-Output "################ BACKUP TOOL ################"
Write-Output "This tool will backup the following folders:"
Write-Output "'$SOURCE_PATH' -> '$TARGET_PATH'"
Write-Output ""
Read-Host -Prompt "Press ENTER to continue or CTRL+C/close this window to exit" 
Write-Output ""
Write-Output "Starting backup..."
do_copy "$SOURCE_PATH" "$TARGET_PATH"
exit 0
