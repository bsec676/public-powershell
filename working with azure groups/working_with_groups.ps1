########################################################################################
##### The following are just a list of AAD Powershell commands dealing with groups #####
########################################################################################

#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds
 
#Get a list of all delete groups
Get-AzureADMSDeletedGroup

#Get Specifics about a group
Get-AzureADMSDeletedGroup -Id "GUID"

#Restore a specific group
Restore-AzureADMSDeletedDirectoryObject –Id "GUID"

#Change Name and alias of group and update all emails addresses
Set-UnifiedGroup -Identity "New Group Name"  -Alias "NewAlias" -EmailAddresses email1@company.com, email1@company.onmicrosoft.com

#Show All Group Attributes
Get-UnifiedGroup -Identity "DisplayName" | Format-List 

#Add New User to group
Add-UnifiedGroupLinks -Identity "DisplayName" -LinkType Members -Links "user@company.com"

#Add group owner
Add-UnifiedGroupLinks -Identity "DisplayName" -LinkType Owners -Links "user@company.com"

#Loop to update all groups with a new owner
$GroupOwner = "user@company.com"

#Get All Office 365 Groups and Add Group Owner
Get-UnifiedGroup -ResultSize Unlimited | ForEach-Object {
    Add-UnifiedGroupLinks –Identity $_.Name –LinkType Members –Links $GroupOwner
    Add-UnifiedGroupLinks –Identity $_.Name –LinkType Owners –Links $GroupOwner
    Write-host "Added Owner to Group:"$_.DisplayName
}


Get-UnifiedGroup | Format-List DisplayName,EmailAddresses,AutoSubscribeNewMembers,AlwaysSubscribeMembersToCalendarEvents,PrimarySmtpAddress,ManagedBy,AccessType
Get-UnifiedGroup | Format-List DisplayName,AccessType,AutoSubscribeNewMembers,AlwaysSubscribeMembersToCalendarEvents,PrimarySmtpAddress,ManagedBy | Export-CSV "DRIVE:\export.csv"

#import groups from CSVFile
$Groups = Import-Csv -Path "DRIVE:\export.csv"

#Loop through groups to create new names for new Microsoft 365 Group Item.
#Allow External Senders
#Subscribe New users to group (this allows emails to be sent to users inboxes)
#Do not subscribe to calendarevents

foreach($Group in $Groups)
{
#New-UnifiedGroup -DisplayName $Group.DisplayName -Alias $Group.MailNickName -RequireSenderAuthenticationEnabled $false -AccessType Private -AutoSubscribeNewMembers $true -SubscriptionEnabled $True -AlwaysSubscribeMembersToCalendarEvents $false   
Set-UnifiedGroup -Identity $Group.DisplayName -RequireSenderAuthenticationEnabled:$false -AccessType Private -AutoSubscribeNewMembers:$true -SubscriptionEnabled:$true -AlwaysSubscribeMembersToCalendarEvents:$false
}


#Loop Trough CSV and import all members of New Microsoft 365 group Item
$entries = Import-Csv "DRIVE:\export.csv"
foreach ($entry in $entries)
    {
        Remove-UnifiedGroupLinks -Identity $entry.DisplayName -LinkType Members -Links $entry.upn -Confirm:$false
        
    }