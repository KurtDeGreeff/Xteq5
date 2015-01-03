﻿# TestUtilHelper module
# Version 1.06
#
# **THIS FILE WILL BE OVERWRITTEN WITHOUT QUESTION. DO NOT ADD YOUR OWN FUNCTIONS HERE.**
#
# Before adding a new function, please see
# [Approved Verbs for Windows PowerShell Commands](http://msdn.microsoft.com/en-us/library/ms714428%28v=vs.85%29.aspx)
#


#require -version 4.0


function Test-TUActive {
<#
  .SYNOPSIS
  Return $true if the script is running within TestUtil

  .PARAMETER 
  None

  .OUTPUTS
  $true if the script is running within TestUtil, $false otherwise
#>
 
 #Better set strict mode on function scope than on module level
 Set-StrictMode -version 2.0

 if (test-path variable:TestUtilActive) {
    return $true 
 } else {
    return $false
 }
}



function Get-TUAssetValue {
<#
  .SYNOPSIS
  Return the value of an asset or the provided default value 

  .DESCRIPTION
  Return the value of an asset or the provided default value.

  The default value is returned when the script is not executed within TestUtil or the asset does not exist.

  .PARAMETER AssetName
  The name of the asset that should be returned 

  .PARAMETER DefaultValue
  The value that should be returned if the asset could not be found or TestUtil is not active

  .OUTPUTS
  Value of the asset or the default value

  .EXAMPLE
  $myValue = Get-TUAssetValue "IsOfficeInstalled" $false
  
  $myValue = Get-TUAssetValue "TotalSuperInstallPath" "C:\TotalSuper"
#>
 param (
 [Parameter(Mandatory=$True,Position=1)]
 [ValidateNotNullOrEmpty()]
 [string]$AssetName, 
 
 [Parameter(Mandatory=$True,Position=2)]
 $DefaultValue
 )

 #Better set strict mode on function scope than on module level to avoid side effects
 Set-StrictMode -version 2.0

  if (Test-TUActive) {
     if ($TestUtilAssets.ContainsKey($AssetName)) {
        #return the value of the key
        return $TestUtilAssets[$AssetName]
     }
     else {
        #hastable does not contain a key with the given name
        return $DefaultValue
     } 
 } 
 else {
    #TestUtil is not active
    return $DefaultValue
 }

 #Done
}


function Test-TUWoW {
<#
  .SYNOPSIS
  Returns $true if the script is affected by WoW64

  .PARAMETER 
  None

  .OUTPUTS
  $true if the script is virtualized with WoW64, $false otherwise
#>
 
 #Better set strict mode on function scope than on module level
 Set-StrictMode -version 2.0

 if ([Environment]::Is64BitOperatingSystem) {
    if ([Environment]::Is64BitProcess) {
       #We are running as 64 bit process on a 64 bit OS. No WOW.
       return $false
    } else {
       #We are not running as a 32 bit process so WoW is active
       return $true 
    }    
 } else {
   #WoW64 is only active on a 64 bit OS 
   return $false
 }
}



