# This script will invoke a DSC configuration
# This is a simple proof of concept

"`n`tPerforming DSC Configuration`n"

. .\Tests\WSUSConfig.ps1
 
( TestWSUS ).FullName | Set-Content -Path .\Artifacts.txt
 
Start-DscConfiguration .\TestWSUS -Wait -Force -verbose
