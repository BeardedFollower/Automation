## ----------------------------------------------------------------------- ##
## Below snippet to be used within other scripts to self-elevate script if required
## 
## Created by BeardedFollower
## ----------------------------------------------------------------------- ##
## To Use:
## copy snippet below into script
## (preferably at the beginning so that it elevates before anything else.)

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
   }