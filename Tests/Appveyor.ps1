# This script will invoke a DSC configuration
# This is a simple proof of concept

New-Item -Path "C:\Windows\system32\WindowsPowerShell\v1.0\Modules" -Name "cMicrosoftUpdate" -Force -ItemType Directory
#New-Item -Path "C:\Program Files\WindowsPowerShell\Modules\cMicrosoftUpdate" -Name "0.0.1" -Force -ItemType Directory
Copy-Item -Path "C:\projects\cmicrosoftupdate\*" -Destination "C:\Windows\system32\WindowsPowerShell\v1.0\Modules\cMicrosoftUpdate"

ls "C:\Program Files\WindowsPowerShell\Modules" -Recurse

Get-module -ListAvailable

Import-module -name cMicrosoftUpdate

Get-DscResource

"`n`tPerforming DSC Configuration`n"

Enable-PSRemoting -Force

. .\Tests\WSUSConfig.ps1
 
( TestWSUS ).FullName | Set-Content -Path .\Artifacts.txt
 
Start-DscConfiguration -Path .\TestWSUS -Wait -Force -verbose
