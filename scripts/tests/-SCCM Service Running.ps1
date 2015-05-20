#v1.05
#https://github.com/texhex/xteq5/wiki/_fwLinkScript


#This script requires PowerShell 4.0 or higher 
#requires -version 4.0

#Guard against common code errors
Set-StrictMode -version 2.0

#Terminate script on errors 
$ErrorActionPreference = 'Stop'$Result = @{Data = "n/a"; Name="SCCM Service running"; Text= "The SCCM Windows Service is running"}if (Get-XQAssetValue "SCCM_Enabled" $false) {    $srvStatus=Get-Service -Name CcmExec -ErrorAction Ignore        #DEBUG ONLY $srvStatus=Get-Service -Name Workstation -ErrorAction Ignore    if ($srvStatus -eq $null) {       $Result.Data="Major"        $Result.Text = "The CcmExec service was not found"        } else {          #add result to output       "Service $($srvStatus.DisplayName) is in state: $($srvStatus.Status)"       if ($srvStatus.Status -ne "Running") {          $Result.Data="Major"           $Result.Text = "The CcmExec service is not running"            } else {          $Result.Data="OK"        }    }}
     


$Result