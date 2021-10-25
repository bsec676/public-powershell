#########################################################################################
#The following lines will create a new shared mailbox#
#########################################################################################

#Import the EOL Module into powershell
Import-Module ExchangeOnlineManagement
#Ask for user creds that have access to update mailboxes
$EOLCreds = Get-Credential
Connect-ExchangeOnline -Credential $EOLCreds

#Import CSV List of users
Import-Csv "mailboxes.csv";

#Create Array from CSV File to go through
$MailboxArray = Import-Csv "mailboxes.csv";

#search through file and create array for Data input
foreach($mailbox in $MailboxArray)
{
    #Create New Shared Mailbox from Mailbox Array Values
    New-Mailbox -Shared -Name $mailbox.newName -DisplayName $mailbox.newDisplayName -Alias $mailbox.newAlias #| Set-Mailbox -GrantSendOnBehalfTo $mailbox.access_rights
    #Uncomment to add permissions for specific accounts
    #Add-MailboxPermission -Identity $mailbox.newDisplayName -User $mailbox.access_rights -AccessRights FullAccess -InheritanceType All
    #Output message stating that Data in Username column has been used to update that account
    Write-Host $mailbox.newDisplayName "has been created." #-ForegroundColor Yellow
     }