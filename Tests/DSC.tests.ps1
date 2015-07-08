Describe "Validate your WSUS Configuration" {
    
    $Global = Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate
    $Configuration = Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU
 
    It "Automatic updates enabled with WSUS Server" {
        $Configuration.UseWUServer | Should be "1"
    }
 
    It "WSUS Server setted to http://127.0.0.1:8080" {
        $Global.WUServer | Should be "http://127.0.0.1:8080"
    }
    
    It "AU Options should be set to notify" {
        $Configuration.AUOptions | Should be "2"
    }
 
    It "Target group is set to DMZ Private" {
        $Global.TargetGroup | Should be "DMZPrivate"
    }
 
    It "Target Group Enabled" {
        $Global.TargetGroupEnabled | Should be "1"
    }
 
    It "WSUS Status Server setted to http://127.0.0.1:8080" {
        $Global.WUStatusServer | Should be "http://127.0.0.1:8080"
    }
 
    It "User can access windows updates site" {
        $Global.DisableWindowsUpdateAccess  | Should be "0"
    }

}