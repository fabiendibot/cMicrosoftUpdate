# This script will invoke a DSC configuration
# This is a simple proof of concept

$env:PSModulePath = $envPSModulePath –replace ";C:\\Program Files (x86)\\Microsoft SQL Server\\130\\Tools\\PowerShell\\Modules\\;C:\\Program Files\\WindowsPowerShell\\Modules\\"

New-Item -Path "C:\Program Files\WindowsPowerShell\Modules" -Name "cMicrosoftUpdate" -Force -ItemType Directory
New-Item -Path "C:\Program Files\WindowsPowerShell\Modules\cMicrosoftUpdate" -Name "0.0.1" -Force -ItemType Directory
Copy-Item -Path "C:\projects\cmicrosoftupdate\*" -Destination "C:\Program Files\WindowsPowerShell\Modules\cMicrosoftUpdate\0.0.1"
Remove-item -path "C:\projects\cmicrosoftupdate" -Recurse -force

get-module  -ListAvailable -FullyQualifiedName cMicrosoftUpdate | Select ModuleBase

$env:PSModulePath

"`n`tPerforming DSC Configuration`n"

Enable-PSRemoting -Force

. .\Tests\WSUSConfig.ps1
 
( TestWSUS ).FullName | Set-Content -Path .\Artifacts.txt
 
Start-DscConfiguration -Path .\TestWSUS -Wait -Force -verbose
