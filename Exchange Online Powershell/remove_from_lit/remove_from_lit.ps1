Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName 

#Import CSV List of users
Import-Csv "lit.csv";

#Create Array from CSV File to go through
$UsersArray = Import-Csv "lit.csv";

#search through file and create array for Data input
foreach($user in $UsersArray)
{
        #Change Hold status to No for File Name
        Set-MailboxSearch $user.name -InPlaceHoldEnabled $false -force
        #Output message stating that Data in Username column has been used to update that account
        Write-Host "Lit Hold has been remove from" $User.Name -ForegroundColor Yellow
        #Delete Name and do not ask for confirmation
        Remove-MailboxSearch $user.name -confirm:$false
        Write-Host $User.Name "has been removed from eDiscovery" -ForegroundColor Green
   }