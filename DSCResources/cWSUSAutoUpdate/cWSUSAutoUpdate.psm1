function Get-TargetResource {
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param (
		[parameter(Mandatory = $true)]
		[ValidateSet("False","True")]
		[System.String]
		$Enable
	)
    Write-Verbose "Get the Windows Server Update Service Autoupdate status"
	Try {
        if ((Get-ItemPropertyValue -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" -name NoAutoUpdate -ErrorAction SilentlyContinue) -eq "1") {
            $Status = "True"
        }
        else {
            $Status = "False"
        }
    }
    Catch {
        $Status = "False"
    }

    $returnValue = @{
		Enable = $Status
	}

	$returnValue
    

}


function Set-TargetResource {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[ValidateSet("False","True")]
		[System.String]
		$Enable
	)

    if ($Enable -eq "False") {
        $value = 1
        Write-Verbose "Disable the Windows Server Update Service Autoupdate"
    }
    else {
        $value = 0
        Write-Verbose "Enable the Windows Server Update Service Autoupdate"
    }


	Set-ItemProperty -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" -name NoAutoUpdate -value $value -type dword


}


function Test-TargetResource {
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param (
		[parameter(Mandatory = $true)]
		[ValidateSet("False","True")]
		[System.String]
		$Enable
	)
    
    Write-Verbose "Test if the Windows Server Update Service Autoupdate Enable is set to: $Enable"
	Try {
        $Status = Get-ItemPropertyValue -path "HKLM:\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" -name NoAutoUpdate -ErrorAction SilentlyContinue
    }
    Catch {
        $Status = "0"
    }

    Switch ($Enable) {
        'False' {
            if ($Status -eq "1") {
                $Return = $True
            }
            else {
                $Return = $False
            }
        }
        'True' {
            if ($Status -eq "1") {
                $Return = $False
            }
            else {
                $Return = $True
            }
        }
    }

    $Return
}


Export-ModuleMember -Function *-TargetResource

