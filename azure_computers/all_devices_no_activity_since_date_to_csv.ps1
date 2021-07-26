#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

#Get Devices that have no activity since XXXX and export them to CSV File
#$dt = (Get-Date).AddDays(-90)
$dt = [datetime]’2020/01/01’
Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | select-object -Property Enabled, DeviceId, DisplayName, DeviceTrustType, ApproximateLastLogonTimestamp | export-csv "devicelist-olderthan-$dt-summary.csv"