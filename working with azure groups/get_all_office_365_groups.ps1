#Get All Office 365 Groups
$GroupData = @()
$Groups = Get-UnifiedGroup -ResultSize Unlimited -SortBy Name

#Loop through each Group
$Groups | Foreach-Object {
    #Get Group Owners
    $GroupOwners = Get-UnifiedGroupLinks -LinkType Owners -Identity $_.Id | Select DisplayName, PrimarySmtpAddress
    $GroupData += New-Object -TypeName PSObject -Property @{
            GroupName = $_.Alias
            GroupEmail = $_.PrimarySmtpAddress 
            OwnerName = $GroupOwners.DisplayName -join "; "
            OwnerIDs = $GroupOwners.PrimarySmtpAddress -join "; "
    }
}
#Get Groups Data
$GroupData
$GroupData | Export-Csv "DRIVE:GroupOwners.csv" -NoTypeInformation

#Remove the session
Remove-PSSession $Session