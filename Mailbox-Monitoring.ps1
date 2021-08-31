# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
   }

$ApplicationId         = '29174932-cc4f-457c-8751-7f77a88f7043'
$ApplicationSecret     = 'hBW/8s7LG52BwXRTwJjUHugUH7R3XWRsvjfJWvtFsBw=' | Convertto-SecureString -AsPlainText -Force
$TenantID              = 'd77d6445-1454-4720-91d4-ef9fdd6a0a44'
$RefreshToken          = '0.AS4ARWR911QUIEeR1O-f3WoKRDJJFylPzHxFh1F_d6iPcEMuAEg.AgABAAAAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P8S-E7puwi29iMQhznMJcGiPmrgvaBATC-8g4Vdk6O3rrDa82rqMjXfd-zxQPtbOCA8ktuV9hW5Bpel1b73aTBkYO1V8NbOelJJ-pecz4q19KqVB-gOj22WlLQrdQdQXWFo3AivsWDe9dmYbmqZoIxie6cozoJfakfJNRtZAKhW8AIfz-xIKApoJPCTI1RXNJ7wHUw3VHLBxmwF4N0F9pKc5ylsR-QL439DbzgXakqRCoNadECOY_1krxnJZdUWcXE8tqOyK0aIfrLuQ0I1DlCM0xEiigVRMzALI2JWij0ZAKkYEiTBGJXyiX_gMZI-bDL0RPtWY5IIUpu6zUfaLyAEzMSQet4lz-tEVYktkxE2fvWySgPxZ7WHbZaz21KS6PZbd3da_qRkZXE3-lnce5C2bsW1d2W2OV57qRKbWWNSvlxyaTe_FvqSjxv57Cq-QAWXEDhMnScRd_38SC8UtbVgLp5cpP_LmVn6z_Ktw9-Mp7CljxGjwLr3kBy__eFeGR3nVmaKh5DLHxVqVSVmc7UUOWd0X3LePO735aMs27BNyDq1HmcJ2_5ho-VRgIGtWPncA2YU0gtk2vRdRQdH2WLTkOq45tWbwAG1FWnumb-FNhanNUQbQteGv2ET7mQeWtlSuXUPrIEX_gBoTu62Gn8gJjZIG5oWKx9ojExmPLVXj9sJofo8MxrorBORQef5zt8Rh8JZDwYpiI34cldLjNsfqNtuRf8Sk3cMxVABQd4l0bv3RlKn8CJ-EwU_t3W1f079AgW5jgJXE7126Zp2L0PVLt0Op6DukuzXMk-Rk1Vk0GvEb-GbQhBdp_Uur9IuEACnqSnJWcy09Gl1etEqNsf8aw9KxJh2m1FTI6kCnRFBE8VlxthameUSztRrN7erN0zXGQbLDtf9vL3QR_Ueuvuv2zZFWNA_lBalvK8ANHOCCLRgzTYV4i-UQqspG8lIzi0WZ2JvCrYSQGnc-pzYPRESZseJPxIHOB37Z0-y-9HOp25-RgRHGelA--rBhHJ6FnJan-qx6lyOhOjx0r6QWphXN0cvKDPTDgxUh67Fm7Ozg7oSmoqKbYDCKxn_MeNoifAyPlqS6jKHqUQmfuo'
$ExchangeRefreshToken  = '0.AS4ARWR911QUIEeR1O-f3WoKRBY8x6Djp2RFmpUr30c4NxYuAEg.AgABAAAAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P-zgJN1bMq072l0k4L7hzc42vU2aAPC9vZVta7VLBTRLcXmrdeCkyNeis88sGH_krRXQSSBK4YheOiE1yPnU-lkr_vNlUOVFtEH8w959TuczS762KBOrDWkXe4Qr_b_MsrVR8XXRPf-rUahjUcZGD5kWvbsQ_W7OKThK6z7TZQpaDKmCn3BF5z_dSVODbUsYWrM7E4xKm7UHw3FkTcbZ9eA4zwhmqDSoOuOXBBFNQCr6YLzPRh-qbnQfHqcmn4tbVMtAwl9S1uYYsL2N4BHmJYaljWdNzDg1FRCF6yvB9FgsdGMwn4ODZVWV_T8RWZiLUAPISGzJ5ZSVKtDq-pw5F_k5u9JsaWNZdGdrTEX00Ojw6PZXIZexpwhK_eSfzisfSzp5bkkoFW4kbTUNIj8-bCnXQprxrxxnLQccCu3p35I4ZfL-7Bj3ZDtyi6OQx6oqt-VkQsqwg289vn8yotoIEB3U9cgLSF562V7Vtg90Q8hb_M_FcIv0bIC8lP3wiRIBS0GMoSaXEEQhQVf6phiTeF8j_Ka52_Ehn4iQrH6vhsSXiuQtirQxqgrQVv5ye_8Qm627aeA9PuDIT24eLjdPvoRVbf4XX-8czAZVm7IhDAYHCOnWGJgBQTKMkpsoM1-0fHvtxHxApYFqwJJMPeatuF76BwRNkEPXooNHTN573jSiiQOgm95FptR8KTX1I5-AOjamalS9jv8YeYo_QusYMDBQCeysZZHe5sgnDnopVeo3dca0Z8auZCaAG7Z21w4xSmrnot1KkxcMRosRkixV2liLZPojR2SreX7qZ-i6vYukGNaiM8zyaocMsBZlZgRQ-6NRqZvHyrMoIOGhaS2Zp0xCKLZf0N5n_YF36lM9xEddXCQUC7ST6mLHR7YaWx6wHaYc9TOOTFmJjlMQPcVex-Fm7b9Y7kfyGswwiEBmxBbmnh1TR4KRfUWxBt0XUP6l6gy0FUf62H3if-JfTpkf_Gk6seL0RVDdjS4Qvtpue3qtJUMuhr-ME_k44IYl5XfAgC7_nQoLiG-ueub_g0wdIn3e5NZDvHtug_ty0fJROopzc2apxPB-VKWGeeiyO0L0DbnybZD4Ccu-KalGcakr4H-4UGUT5boAz53I-Md'
$upn                   = 'david@computerhelperga.com'
$SizeToMonitor         = 40


## Determine if MSOnline is installed, else install.
if (Get-Module -ListAvailable -Name MSOnline) {
    Write-Host "MSOnline Module installed, continuing script..." -foregroundcolor green
} 
else {
    Write-Host "MSOnline Module is not installed, installing" -foregroundcolor red
    Install-Module -Name MSOnline
}
## Determine if module is installed, else install.
if (Get-Module -ListAvailable -Name AzureAD) {
    Write-Host "AzureAD Module installed, continuing script..." -foregroundcolor green
} 
else {
    Write-Host "MSOnline Module is not installed, installing..." -foregroundcolor red
    Install-Module -Name AzureAD
}
## Determine if module is installed, else install.
if (Get-Module -ListAvailable -Name PartnerCenter) {
    Write-Host "PartnerCenter Module installed, continuing script..." -foregroundcolor green
} 
else {
    Write-Host "PartnerCenter Module is not installed, installing..." -foregroundcolor red
    Install-Module -Name PartnerCenter -AllowClobber -Scope AllUsers
}

## create temp folder location for exported report
$Dir = "C:\temp"
If(!(test-path $Dir))
    {
        Write-Host "C:\Temp does not exist, creating C:\temp" -foregroundcolor red
		New-Item -ItemType Directory -Force -Path $Dir
    }
else {
    Write-Host "Export Location exists, when the script completes, check C:\temp for more information." -foregroundcolor yellow
}    

$credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)
$aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal -Tenant $tenantID 
$graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default' -ServicePrincipal -Tenant $tenantID 
Connect-MsolService -AdGraphAccessToken $aadGraphToken.AccessToken -MsGraphAccessToken $graphToken.AccessToken
$customers = Get-MsolPartnerContract -All
foreach ($customer in $customers) {
    write-host "Getting started for $($Customer.name)" -foregroundcolor green
    $token = New-PartnerAccessToken -ApplicationId 'a0c73c16-a7e3-4564-9a95-2bdf47383716'-RefreshToken $ExchangeRefreshToken -Scopes 'https://outlook.office365.com/.default' -Tenant $customer.TenantId
    $tokenValue = ConvertTo-SecureString "Bearer $($token.AccessToken)" -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($upn, $tokenValue)
    $customerId = $customer.DefaultDomainName
    $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://ps.outlook.com/powershell-liveid?DelegatedOrg=$($customerId)&amp;BasicAuthToOAuthConversion=true" -Credential $credential -Authentication Basic -AllowRedirection
    Import-PSSession $session -allowclobber -Disablenamechecking
    $Mailboxes = Get-Mailbox | Get-MailboxStatistics | Select-Object DisplayName, @{name = "TotalItemSize (GB)"; expression = { [math]::Round((($_.TotalItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2) } }, ItemCount | Sort-Object "TotalItemSize (GB)" -Descending
    foreach ($Mailbox in $Mailboxes) {
        if ($Mailbox.'TotalItemSize (GB)' -gt  $SizeToMonitor) {
            $Mailbox | Export-CSV "C:\temp\Large-Mailboxes.csv" -NoTypeInformation -append
        }
    }
    Remove-PSSession $session
}
Write-Host "Export is complete. Check C:\temp\Large-Mailboxes.csv for more information."