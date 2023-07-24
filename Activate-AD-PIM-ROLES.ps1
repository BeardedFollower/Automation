<#
This PowerShell module contains a collection of tools for Microsoft 365 security tasks
such as Microsoft Graph functions, Azure AD management, Conditional Access, zero trust strategies, attack and defense scenarios, etc.
#>
#Install-Module -Name DCToolbox -Force -Scope AllUsers

<#
PowerShell module for MSAL. MSAL.NET (Microsoft.Identity.Client) is an authentication library which enables you to acquire tokens from Azure AD,
to access protected Web APIs (Microsoft APIs or applications registered with Azure Active Directory).
#>
#Install-Package msal.ps -Force -Scope AllUsers

<#
NOTE: If you have AzureAD module installed, please remove first and then install the AzureADPreview
#>
#Install-Module -Name AzureADPreview -Force -Scope AllUsers

<#
The RemoteSigned policy allows us to run scripts that we have created locally, but scripts that we download must be digitally signed by a trusted publisher. The Unrestricted policy carries no restrictions at all, and allows us to run unsigned scripts from any source.#
#>
#Set-ExecutionPolicy RemoteSigned

<#
After "RolesToActivate" you will enter the name of the role you want active, the format can been seen below.
There doesn't seem to be a limited on how many you can add. 
#>
Enable-DCAzureADPIMRole -RolesToActivate 'User Administrator', 'Authentication Administrator' , 'Service Support Administrator' , 'Printer Administrator' , 'Groups Administrator' , 'Security Reader' -UseMaximumTimeAllowed -Reason 'Work Day'


#After you have completed the installs, and ran Set-ExecutionPolicy RemoteSigned you no longer need to run these. You can copy the "Enable-DCAzureADPIMRole -RolesToActivate xxxx" over into it's own script and save to desktop and just run it normally. 