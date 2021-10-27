Get-ExecutionPolicy
Set-ExecutionPolicy Unrestricted –Scope CurrentUser

$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService –Credential $UserCredential
 
Get-MsolUser -all | select DisplayName,UserPrincipalName,@{
N="MFA Status"; E={ if( $_.StrongAuthenticationRequirements.State -ne $null)
{ $_.StrongAuthenticationRequirements.State} else 
{ "Disabled"
}
}
},Department, UserType, ObjectId, Manager | Sort-Object "MFA Status", DisplayName | Export-Csv "mfaexport.csv"


get-msoluser -UserprincipalName upn@company.com -properties *

Set-AzureADUserManager -ObjectId "" -RefObjectId ""

Get-MsolUser -ObjectID UserPrincipalName

Get-AzureADUser -ObjectID UserPrincipalName
Get-AzureADUserManager -ObjectID UserPrincipalName