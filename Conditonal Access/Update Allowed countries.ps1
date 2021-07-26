##########################################################################################################################
###### What does this script do?                                                                                    ######
###### The blow powershell script is run to update a specific policy in AzureAD Conditional Access                  ######
###### I have created a Conditional Access Poilcy in AzureAD called "Allowed Countries"                             ######
###### The policy only allows access to AzureAD if you are coming from an IP Range within the allowed countries     ######
###### This script is a work in progress                                                                            ######
##########################################################################################################################

#########################Examples#########################
#Get Help
#Get-help AzureADMSConditionalAccessPolicy
#Get all Conditional Policies
#Get-AzureADMSConditionalAccessPolicy

#Get Named Locations
#Get-AzureADMSNamedLocationPolicy -PolicyId  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

#Example 1: Update an ip named location policy in Azure AD by PolicyId
#Set-AzureADMSNamedLocationPolicy -PolicyId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -OdataType "#microsoft.graph.ipNamedLocation" -IsTrusted $false
#Update a country named location policy in Azure AD by PolicyId
#Set-AzureADMSNamedLocationPolicy -PolicyId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -OdataType "#microsoft.graph.countryNamedLocation" -IncludeUnknownCountriesAndRegions $true

#Test The following line will add the countries to the choosen policy
#$ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
#$ipRanges.cidrAddress = "6.5.4.3/32"
#$ipRanges = ("6.5.4.3/32")
#Set-AzureADMSNamedLocationPolicy -PolicyId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -OdataType "#microsoft.graph.ipNamedLocation" -IpRanges $ipRanges
##########################################################

#########################Policies#########################
# Current Policies to Update or Test
# Allowed Countries - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# PSTest Country - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# PSTest IPRange - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
##########################################################


#Check to see if the user has the AzureAD module installed/loaded
if (!(Get-Module "AzureAD")) {
    Write-host `r "AzureAD Module Not Installed or running. Installing now!" -ForegroundColor yellow
    Install-Module -Name AzureAD -Force
}else { 
        Write-host `r "AzureAD Module Installed - Continuing" -ForegroundColor green
}

#Connect to AzureAD if not already
if($azureConnection.Account -eq $null){
    $azureConnection = Connect-AzureAD
}

#Connected to AzureAD
#Connect-AzureAD

#######################################################################################################
############### Manually input all current policies & then show the policy as an option ###############
############### I've created an allow countries policy that this script updates         ###############
############### Currently Testing this                                                  ###############
#######################################################################################################
#Function Get-Site
#{
#	$site=Read-Host "Policy to update "
#	Switch ($site)
#	{
#		1 {$Chosensite="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"}
#		2 {$Chosensite="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"}
#       3 {$Chosensite="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"}
#		
#		}
#   return $Chosensite
#}
#$policy_update = Get-Site
#Write-Host $policy_update
###################################
###################################

#Ask what countries should be in the Rule.
$Reponse = 'Y'
$Country = $Null
$Countries = @("US")
$WriteOutList = $Null

$USonly = Read-Host 'Do you want to add countries to the Policy Rule? (y/n)'
Write-host ""

If ($USonly -ne "n") {
Do 
{ 
    $Country = Read-Host `r 'Please enter one (1) country in abbreviated form (Mexico=MX) you want in the Policy List'
    $Response = Read-Host `r 'Would you like to add another country to this list? (y/n)'
    $Countries += $Country
}
Until ($Response -eq 'n')
}

Write-Host "You are about to add the following to the Countries list in Policy" -ForegroundColor yellow
Write-host ""
Write-host $Countries -ForegroundColor yellow
Write-host ""

$continue = Read-Host 'Do you want to continue updating this rule? (y/n)'

If ($continue -eq "y"){
#Update Allowed Countries 
Set-AzureADMSNamedLocationPolicy -PolicyId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -OdataType "#microsoft.graph.countryNamedLocation" -CountriesAndRegions $Countries
Write-Host `r "The Allowed Countries Rule has been updated with - " -ForegroundColor green 
write-host ""
Write-Output $Countries
}Else {
Write-Host `r "The Allowed Countries Rule will not be updated. " -ForegroundColor red
}
