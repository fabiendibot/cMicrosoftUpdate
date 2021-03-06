function Get-TargetResource {
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param (
		[parameter(Mandatory = $true)]
        [ValidateSet("True","False")]      
		[System.String]
		$Enable
	)

	Write-Verbose "Get the Windows Server Update Service Elevate Non Admins is Enabled"

    Try {
       if ((Get-ItemPropertyValue -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" -name ElevateNonAdmins -ErrorAction SilentlyContinue) -eq "1") {
           $State = "True"
       }
       else { $State = "False" } 
    }
    Catch {
       $State = "False"
    }
	
	$returnValue = @{
		Enable = $State
	}

	$returnValue
}


function Set-TargetResource {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
        [ValidateSet("True","False")]      
		[System.String]
		$Enable
	)

    Write-Verbose "Set the Windows Server Update Service Elevate Non Admins is Enabled to: $Enable"

	if ($Enable -eq "True") {
        Set-ItemProperty -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" -name ElevateNonAdmins -Value 1 -type dword -Force
    }
    else {
        Set-ItemProperty -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" -name ElevateNonAdmins -Value 0 -type dword -Force
    }


}


function Test-TargetResource {
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param (
		[parameter(Mandatory = $true)]
        [ValidateSet("True","False")]      
		[System.String]
		$Enable
	)

	Write-Verbose "Test if the Windows Server Update Service Elevate Non Admins is set to: $Enable"

    Try {
       $Elevation = Get-ItemPropertyValue -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" -name ElevateNonAdmins -ErrorAction SilentlyContinue
    }
    Catch {
       $Elevation = "0"
    }

    if ( $Elevation -eq "1") { 
        if ($Enable -eq "True") {
            $Return = $true
        }
        elseif ($Enable -eq "False") {
            $Return = $false
        }
    }
    elseif ($Elevation -eq "0") {
        if ($Enable -eq "False") {
            $Return = $True
        }
        elseif ($Enable -eq "True") {
            $Return = $False
        }
    }
    else { $Return = $false }
    $Return
}


Export-ModuleMember -Function *-TargetResource

