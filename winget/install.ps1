#!/usr/bin/env pwsh

$manifest_file = $args[0]

function check_file_not_null {
    Param([string]$manifest_file)
    if (!$manifest_file){
        Write-Error "A JSON manifest file was not provided. Please provide manifest file as a command line argument."
        confirm_exit
    }
}

function check_file_exists {
    Param([string]$manifest_file)
    if (!(Test-Path $manifest_file -PathType Leaf)) {
        Write-Error "'$manifest_file' does not exist. Please check and try again."
        confirm_exit
    }
}

function run_winget {
    Param([string]$manifest_file)
    try {
        Winget import -i $manifest_file --accept-source-agreements --accept-package-agreements
    } catch [System.SystemException] {
        Write-Error "Something went wrong..."
        Write-Error $_
        exit 1
    }   
}

function list_packages {
    Param([string]$manifest_file)
    $data = Get-Content $manifest_file -Raw | ConvertFrom-Json
    $packages = $data.Sources[0].Packages
    foreach ($package in $packages) {
        Write-Output $package.PackageIdentifier
    }
}

function confirm_continue {
    Write-Output "Press ENTER to continue or press CTRL+C, or close this window to exit"
    [console]::TreatControlCAsInput = $true
    while ($true) {
        if ([console]::KeyAvailable) {
            $key = [system.console]::readkey($true)
            if (($key.modifiers -band [consolemodifiers]"control") -and ($key.key -eq "C")) {
                exit 0
            } elseif ($key.key -eq "ENTER") {
                break
            }
        }
    }
}

function confirm_exit {
    Read-Host -Prompt "Press ENTER, CTRL+C, or close this window to exit"
    exit 0
}

check_file_not_null $manifest_file
check_file_exists $manifest_file
Write-Warning "This will install the following packages:"
list_packages $manifest_file
confirm_continue
run_winget $manifest_file
Write-Output "Installation complete. Please see console output for details."
confirm_exit
