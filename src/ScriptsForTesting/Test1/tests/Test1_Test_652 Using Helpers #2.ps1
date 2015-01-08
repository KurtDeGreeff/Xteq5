#Script requires PowerShell 4.0 or higher - http://blogs.msdn.com/b/powershell/archive/2009/02/06/requires-your-scripts.aspx
#require -version 4.0

#Guard against common code errors - http://technet.microsoft.com/en-us/library/ff730970.aspx
Set-StrictMode -version 2.0

#Terminate on errors - http://blogs.technet.com/b/heyscriptingguy/archive/2010/03/08/hey-scripting-guy-march-8-2010.aspx$ErrorActionPreference = 'Stop'#Default is MAJOR because we expect the value to exist$myReturn = @{Name="Value from Asset using Helper function"; Data = "Major"; Text= "An asset named FromAsset550 exists and could be retrieved with a different upper/lower case name"}$valueasset=Get-XQAssetValue "fromASSet550" $false #should return TRUEif ($valueasset -eq $true) {   $myReturn.Data="OK"; #This means Success}else { #Something didn't work out $myReturn.Data="fail" $myReturn.Text="Result was not TRUE!"}$myReturn