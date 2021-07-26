#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

#Show all devices in AzureAD sort by Last Login Time
Get-AzureADDevice -All:$true | select-object -Property Enabled, DeviceId, DisplayName, DeviceTrustType, ApproximateLastLogonTimestamp | Sort -Property ApproximateLastLogonTimestamp | ft