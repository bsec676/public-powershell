#Remove Old Owner and Replace with new Owner


#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

$Groups = Read-Host -Prompt "What is the Display Name of the Group you want to update?"
$new = Read-Host -Prompt "What is the NEW owners email address?"
$old = Read-Host -Prompt "What is the OLD owners email address?"

Add-UnifiedGroupLinks -Identity $groups -LinkType Members -Links $new
Add-UnifiedGroupLinks -Identity $Groups -LinkType Owners -Links $new
Remove-UnifiedGroupLinks -Identity $Groups -LinkType Owners -Links $old
Remove-UnifiedGroupLinks -Identity $Groups -LinkType Members -Links $old