## ----------------------------------------------------------------------- ##
## Script Created to ease updates of PowerBI on the Azure VDI Session Hosts
## Created by BeardedFollower
## ----------------------------------------------------------------------- ##
## To Use: copy powershell script to session host, run script, might have to approve admin consent for powerbi installer

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
   }

## Define Variables Used In Script
$TempFolderLocation = "C:\temp"
$PowerBIURL = "https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe"
$installerPath = "$($TempFolderLocation)\PBIDesktopSetup_x64.exe"

## Below writes message to powershell window about usage of script
Write-Host "This Script will force update PowerBI Desktop Standalone"

## Make temporary location for PowerBI Download, if it doesn't exist
if (Test-Path $TempFolderLocation) {
   Write-Host "Temp Folder Exists, Continuing Installation."
}
else
{
    #Create the directory if not exists
    Write-Host "Temp Folder Does Not Exist, Creating."
    New-Item $TempFolderLocation -ItemType Directory
}

## Connct to the Microsoft Website and download the necessary file to the $TempFolderLocation directory
Write-host "Beginning Download of PowerBI"
Invoke-WebRequest -Uri $PowerBIURL -OutFile "$installerPath" -UseBasicParsing

## Run the downloaded file and update as necessary.
Write-Host "Download Complete, Beginning Installation."
Start-Process -FilePath $installerPath -ArgumentList "/q /norestart ACCEPT_EULA=1" -verb runas
