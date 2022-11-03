# Usage

## Auto Unattend XML Generator
1. [Simple autounattend.xml Generator](https://vicholz.github.io/viewhtml.html#https://raw.githubusercontent.com/vicholz/vicholz.github.io/main/simple_autounattend.html)

## [autounattend.xml](https://raw.githubusercontent.com/vicholz/windows_tools/main/install/autounattend.xml)

1. Download the file.
1. Modify the following lines (optional):
   1. Line 102 - Display name of the local user account.
   1. Line 103 - Group the user is part of.
   1. Line 104 -  Username of the user.
   1. Line 82 - Username of the user from line 104 for autologin on boot.
1. Copy the file to the root directory of your USB installer.
1. Use the installer.

## [win11_req_bypass.bat](https://raw.githubusercontent.com/vicholz/windows_tools/main/install/win11_req_bypass.bat)

1. Download the file.
1. Copy the file to the root directory of your USB installer.
1. Start the install.
1. Once you see the start setup dialog press `SHIFT+F10` which will open a command prompt window.
1. Type: `d: <ENTER>` NOTE: the drive letter for your USB installer may be different if there are multiple partitions/drives in the machine so try e, f, etc.
1. Type: `dir <ENTER>`
1. You should see `win11_req_bypass.bat` in the list of files.
1. Type: `win11_req_bypass.bat <ENTER>`
1. Close the command prompt and continue the setup as usual.
