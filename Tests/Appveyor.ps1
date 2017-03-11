# This script will invoke a DSC configuration
$PSModuleAutoloadingPreference = “none”

New-Item -Path "C:\Users\appveyor\Documents\WindowsPowerShell\Modules" -Name "cMicrosoftUpdate" -Force -ItemType Directory
New-Item -Path "C:\Users\appveyor\Documents\WindowsPowerShell\Modules\cMicrosoftUpdate" -Name "0.0.1" -Force -ItemType Directory
Copy-Item -Path "C:\projects\cmicrosoftupdate\*" -Destination "C:\Users\appveyor\Documents\WindowsPowerShell\Modules\cMicrosoftUpdate\0.0.1"

"`n`tPerforming DSC Configuration`n"

Enable-PSRemoting -Force

. .\Tests\WSUSConfig.ps1
 
( TestWSUS ).FullName | Set-Content -Path .\Artifacts.txt
 
Start-DscConfiguration -Path .\TestWSUS -Wait -Force -verbose
