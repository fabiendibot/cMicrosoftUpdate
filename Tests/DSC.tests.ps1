Describe "Web Server"  {
    It "Is Installed" {
        $Output = Get-WindowsFeature web-server
        $Output.InstallState | Should Be "Installed"
    }
}