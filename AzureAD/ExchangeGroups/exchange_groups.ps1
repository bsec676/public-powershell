#Create Group

#Connect to Exchange Online
Import-Module ExchangeOnlineManagement
$cred = Get-Credential 
Connect-ExchangeOnline -Credential $cred

#Create the group names GroupName with a Display Name of "Group Name" and an email address of "userPrincipalName@company.com" with alias of userPrincipalName Allow users from outside the org to send emails and then add these members to the group
#This script can be setup a bit better by using a csv file to import all the attributes
New-DistributionGroup -Type Distribution -Name "GroupName" -DisplayName "Group Name" -PrimarySmtpAddress "userPrincipalName@company.com" -Alias "userPrincipalName" -RequireSenderAuthenticationEnabled $false -Members user1@company.com,user2@company.com,user3@company.com,user4@company.com
