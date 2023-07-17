#!/usr/bin/env pwsh

function confirmed_exit {
    Read-Host -Prompt "Press ENTER or CTRL+C or close this window to exit"
    exit 0
}

function check_if_exists {
    Param([string]$path)
    Write-Output "Checking path '$path'..."
    if (!(Test-Path -Path $path)){
        try {
            Write-Output "Target path '$path' does not exist. Creating..."
            New-Item -ItemType Directory -Path $path
            Write-Output "Target path '$path' does not exist. Creating...DONE!"
        } catch {
            Write-Output "ERROR! Could not create path '$path'. Please check and try again."
            return false
        }
        return $false
    } else {
        return $true
    }
}

function do_copy {
    Param([string]$source, [string]$target)
    Write-Output "Copying '$source' to '$target'..."
    "robocopy '$source' '$target' $ROBOCOPY_PARAMS" | Invoke-Expression
    Write-Output "Copying '$source' to '$target'...DONE!"
}

function prompt_for_backup_location {
    $CONFIRMATION = "n"
    while (![Environment]::GetEnvironmentVariable("BACKUP_PATH", "User")) {
        $BACKUP_PATH = Read-Host "Please enter the backup target location (preferrably an external drive or network location)"
        while ($CONFIRMATION.ToLower() -ne "y" -or $CONFIRMATION.ToLower() -ne "n") {
            $CONFIRMATION = Read-Host "You entered '$BACKUP_PATH'. Is this correct? (y/n)"
            if ($CONFIRMATION.ToLower() -eq "y"){
                Write-Output "Setting 'BACKUP_PATH' environment variable for user to '$BACKUP_PATH'..."
                [Environment]::SetEnvironmentVariable("BACKUP_PATH", $BACKUP_PATH, 'User')
                Write-Output "Setting 'BACKUP_PATH' environment variable for user to '$BACKUP_PATH'...DONE!"
                return
            } else {
                break
            }
        }
    }
}

### MAIN ###
prompt_for_backup_location

$BACKUP_PATH = [Environment]::GetEnvironmentVariable("BACKUP_PATH", "User")
$HOSTNAME = "$env:COMPUTERNAME"
$USERNAME = "$env:USERNAME"
$TARGET_PATH = "$BACKUP_PATH\$HOSTNAME\$USERNAME\BACKUP"

$SOURCE_PATH = Get-Location
$SOURCE_DIR_NAME = Split-Path -Path (Get-Location) -Leaf

$TARGET_PATH = "$TARGET_PATH\$SOURCE_DIR_NAME"

$ROBOCOPY_CONFIG = "/R:3 /W:5 /S /Z /XO /FFT /MT /COMPRESS /ETA"
$ROBOCOPY_EXCLUDES = "/XF '*.gdoc' '*.gsheets' '*.gslides' '*.gdraw'"
$ROBOCOPY_LOG = "/TEE /LOG:backup.log"
$ROBOCOPY_PARAMS = "$ROBOCOPY_CONFIG $ROBOCOPY_EXCLUDES $ROBOCOPY_LOG"

if (!(check_if_exists $TARGET_PATH)) {
    Write-Output "Aborted."
    confirmed_exit
}

Write-Output "################ BACKUP TOOL ################"
Write-Output "This tool will backup the following folders:"
Write-Output "'$SOURCE_PATH' -> '$TARGET_PATH'"
Write-Output ""
Read-Host -Prompt "Press ENTER to continue or CTRL+C/close this window to exit" 
Write-Output ""
Write-Output "Starting backup..."
do_copy "$SOURCE_PATH" "$TARGET_PATH"
confirmed_exit
