#Script requires PowerShell 4.0 or higher - http://blogs.msdn.com/b/powershell/archive/2009/02/06/requires-your-scripts.aspx
#require -version 4.0

#Guard against common code errors - http://technet.microsoft.com/en-us/library/ff730970.aspx
Set-StrictMode -version 2.0

#Terminate on errors - http://blogs.technet.com/b/heyscriptingguy/archive/2010/03/08/hey-scripting-guy-march-8-2010.aspx
$ErrorActionPreference = 'Stop'


#The variable name you use is not important, just the fields (.Data etc.) are important$MyNameIsBond_JamesBond = @{Name = "Asset #007 from script"; Data = "Asset #007 Data"; Text = "Asset #007 Text"}
$MyNameIsBond_JamesBond