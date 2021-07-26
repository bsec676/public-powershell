#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds


#Set Devices to Disabled that are older than the date
$dt = [datetime]’2020/01/01’
Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | Set-AzureADDevice -AccountEnabled:$False

#Set-AzureADDevice -ObjectId "IdOfDevice" -AccountEnabled:$False

#Get All Devices and sort by Displayname
#Get-AzureADDevice -All:$true | Sort -property DisplayName

#Get a specific Device 
#Get-AzureADDeviceRegisteredOwner -ObjectId "IDOfDevice"