#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

# Get CSV content
$CSVrecords = Import-Csv "users.csv" -Delimiter ","

# Create arrays for skipped and failed users
$SkippedUsers = @()
$FailedUsers = @()

# Loop trough CSV records
foreach ($CSVrecord in $CSVrecords) {
    $upn = $CSVrecord.UserPrincipalName
    $user = Get-AzureADUser -Filter "userPrincipalName eq '$upn'"  
    if ($user) {
        try{
        $user | Set-AzureADUser -Department $CSVrecord.Department -CompanyName $CSVrecord.CompanyName -JobTitle $CSVrecord.JobTitle
        } catch {
        $FailedUsers += $upn
        Write-Warning "$upn user found, but FAILED to update."
        }
    }
    else {
        Write-Warning "$upn not found, skipped"
        $SkippedUsers += $upn
    }
}

# Array skipped users
$SkippedUsers

# Array failed users
#$FailedUsers

