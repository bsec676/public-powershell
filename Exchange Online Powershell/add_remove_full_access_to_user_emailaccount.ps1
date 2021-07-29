#########################################################################################
#The following lines will add a user to have full access to another users emails account#
#########################################################################################

#Import the EOL Module into powershell
Import-Module ExchangeOnlineManagement
#Ask for user creds that have access to update mailboxes
$EOLCreds = Get-Credential
Connect-ExchangeOnline -Credential $EOLCreds

#Add User1 to User2s mailbox with full rights
Add-MailboxPermission -Identity user2@company.com -User user1@company.com -AccessRights FullAccess -InheritanceType All
Remove-MailboxPermission -Identity user2@company.com -User user1@company.com -AccessRights FullAccess -InheritanceType All