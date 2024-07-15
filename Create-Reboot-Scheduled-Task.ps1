## ----------------------------------------------------------------------- ##
## Script Created to allow for the creation of a scheduled task on a given machine
## so that the machine would auto-restart daily at 1AM
##
## Created by BeardedFollower
## ----------------------------------------------------------------------- ##
## To Use:
## copy powershell script to machine, and run with admin privleges.

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
   }

# Begin Main Script  
# Create task action
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'Restart-Computer -Force'
# Create a trigger (Daily at 1AM)
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 1am
# The user to run the task
$taskUser = New-ScheduledTaskPrincipal -UserId "LOCALSERVICE" -LogonType ServiceAccount
# The name of the scheduled task.
$taskName = "Daily Reboot - 1AM"
# Describe the scheduled task.
$description = "Forcibly reboot the computer daily at 1AM"
# Register the scheduled task
Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Principal $taskUser -Description $description
