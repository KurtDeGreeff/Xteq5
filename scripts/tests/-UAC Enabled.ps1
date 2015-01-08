#v1.01
#https://github.com/texhex/xteq5/wiki/_fwLinkScript


#This script requires PowerShell 4.0 or higher 
#require -version 4.0

#Guard against common code errors
Set-StrictMode -version 2.0

#Terminate script on errors 
$ErrorActionPreference = 'Stop'
 $test = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -ErrorAction Ignore 
 
 if($test -ne $null) {
   if ($test.EnableLUA -eq 1) {
       $Result.Data="OK" 
       $Result.Text="User Account Control (UAC) is enabled"
   }
 }

 
