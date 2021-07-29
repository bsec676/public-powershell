#########################################################################################
#                   Comparing 2 users and the groups they are a part of                 #
#########################################################################################

#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

#Ask for the users email addresses
$user1 = Read-Host -Prompt "What is the E-mail of user 1?"
$user2 = Read-Host -Prompt "What is the E-mail of user 2?"

#Search the groups that the users are part of and then output them on the screen
Write-Host $user1 "groups are"
Get-AzureADUserMembership -ObjectId $user1 | foreach {
Get-AzureADGroup -ObjectId $_.ObjectID | Select DisplayName
}
"`n"
Write-Host $user2 "groups are" "`n"
Get-AzureADUserMembership -ObjectId $user2 | foreach {
Get-AzureADGroup -ObjectId $_.ObjectID | Select DisplayName
}