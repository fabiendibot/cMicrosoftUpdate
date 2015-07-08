# This script will invoke a DSC configuration
# This is a simple proof of concept

Install-Module -Name xPSDesiredStateConfiguration -Force

"`n`tPerforming DSC Configuration`n"

. .\DSC\NewWebSite.ps1
 
( NewPullServer ).FullName | Set-Content -Path .\Artifacts.txt
 
Start-DscConfiguration .\NewPullServer -Wait -Force -verbose
