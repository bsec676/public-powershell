#------------------------------------------------------------------------------ 
# 
# Copyright © 2013 Microsoft Corporation.  All rights reserved. 
# 
# THIS CODE AND ANY ASSOCIATED INFORMATION ARE PROVIDED “AS IS” WITHOUT 
# WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT 
# LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS 
# FOR A PARTICULAR PURPOSE. THE ENTIRE RISK OF USE, INABILITY TO USE, OR  
# RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER. 
# 
#------------------------------------------------------------------------------ 
 
Import-Module MSOnline 
$cred = Get-Credential 
Connect-MsolService -Credential $cred 
 
 #Change TENANT: to match your ADD Name
$oldLicense = "TENANT:O365_BUSINESS_PREMIUM" 
$oldLicense2 = "TENANT:AAD_PREMIUM"
$newLicense = "TENANT:SPE_E5" 
 
$users = Get-MsolUser -MaxResults 5000 | Where-Object { $_.isLicensed -eq "TRUE" }
$modifiedUserCount = 0 
 
foreach ($user in $users){ 
    $upn = $user.UserPrincipalName 
    foreach ($license in $user.Licenses) { 
        if ($license.AccountSkuId -eq $oldLicense2) { 
            $disabledPlans = @() 
            foreach ($licenseStatus in $license.ServiceStatus) { 
                $plan = $licenseStatus.ServicePlan.ServiceName 
                $status = $licenseStatus.ProvisioningStatus 
                if ($status -eq "Disabled") { 
                    # We found a disabled service. We might need to translate it. 
                    # For example, in an E1 license, Exchange Online is called "EXCHANGE_S_STANDARD", and 
                    # in an E3 license it's called "EXCHANGE_ENTERPRISE". 
 
                    if ($plan -eq "EXCHANGE_S_STANDARD") { 
                        #$disabledPlans += "EXCHANGE_S_ENTERPRISE" 
                    } elseif ($plan -eq "SHAREPOINTENTERPRISE") { 
                     #   $disabledPlans += "SHAREPOINTWAC" 
                    #    $disabledPlans += "SHAREPOINTSTANDARD" 
                    } #elseif($plan -eq "SWAY"){
                    } #elseif($plan -eq "SHAREPOINTWAC"){
                    } #elseif($plan -eq "FORMS_PLAN_E1"){
                        }else { 
                        # Example: MCOSTANDARD 
                        $disabledPlans += $plan 
                    }
                                      
                } 
            } 

            $disabledPlans = $disabledPlans | select -Unique 
            if ($disabledPlans.Length -eq 0) { 
                Write-Host("User $upn will go from $oldLicense and $oldLicense2 to $newLicense and will have no options disabled.") 
                Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $newLicense -RemoveLicenses $oldLicense
                Set-MsolUserLicense -userPrincipalName $upn -AddLicenses $newLicense2 -RemoveLicenses $oldLicense2
                $modifiedUserCount++  
            } else { 
                $options = New-MsolLicenseOptions -AccountSkuId $newLicense -DisabledPlans $disabledPlans
                Write-Host("User $upn will go from $oldLicense and $oldLicense2 to $newLicense will have these options disabled: $disabledPlans") 
                Write-Host("Options: $options")
                Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $newLicense -LicenseOptions $options -RemoveLicenses $oldLicense
                Set-MsolUserLicense -userPrincipalName $upn -AddLicenses $newLicense2 -RemoveLicenses $oldLicense2
                $modifiedUserCount++  
            } 
        } 
    } 
}
$usercount = ($users).Count
Write-Host ("Users Processed: $usercount")
Write-Host ("Users Modified: $modifiedUserCount")