#user to connect as
$eoluser = "user@company.com"

#connect to EOL
Connect-ExchangeOnline -UserPrincipalName $eoluser
Set-UnifiedGroup -Identity GUID -PrimarySmtpAddress newaddress@company.com