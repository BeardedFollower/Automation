## ----------------------------------------------------------------------- ##
## Script Created to automatically activate Microsoft Entra Privileged Identity Management 
## Created by BeardedFollower
## Last Updated 02/13/2025
## ----------------------------------------------------------------------- ##
## To Use: copy ps script to machine, run script, log into account

## Variables ##
## Define Roles to Activate Here ##
$Roles = 'Authentication Administrator' , 'Groups Administrator' , 'Printer Administrator' , 'Reports Reader' , 'Security Reader' , 'User Administrator', 'Service Support Administrator' , 'User Administrator'
$ReasonForActivation = Read-Host

#This PowerShell module contains a collection of tools for Microsoft 365 security tasks, Microsoft Graph functions, Azure AD management, Conditional Access, zero trust strategies, attack and defense scenarios, etc.#
if(-not (Get-Module DCToolbox -ListAvailable)){
    Install-Module DCToolbox -Scope AllUsers -Force
    }

#PowerShell module for MSAL. MSAL.NET (Microsoft.Identity.Client) is an authentication library which enables you to acquire tokens from Azure AD, to access protected Web APIs (Microsoft APIs or applications registered with Azure Active Directory).#  
if(-not (Get-Package msal.ps)){
    Install-Package msal.ps -Force -Scope AllUsers
    } 

#This checkes to see if AzureAD Preview is installed and if not install it.
if(-not (Get-Module AzureADPreview -ListAvailable)){
    Install-Module AzureADPreview -Scope AllUsers -Force
    } 

# geThe RemoteSigned policy allows us to run scripts that we have created locally, but scripts that we download must be digitally signed by a trusted publisher. The Unrestricted policy carries no restrictions at all, and allows us to run unsigned scripts from any source.
# Set-ExecutionPolicy RemoteSigned

#After "RolesToActivate" you will enter the name of the role you want active, the format can been seen from above. There doesn't seem to be a limited on how many you can add. 
Enable-DCAzureADPIMRole -RolesToActivate $Roles -UseMaximumTimeAllowed -Reason $ReasonForActivation
