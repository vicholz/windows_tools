if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

get-appxpackage -AllUsers *xbox* | remove-appxpackage

winget uninstall OneDriveSetup.exe

# permanent - cannot reinstall from MS Store
#get-appxprovisionedpackage –online | where-object {$_.packagename –like “*xboxapp*”} | remove-appxprovisionedpackage –onlinedsda
