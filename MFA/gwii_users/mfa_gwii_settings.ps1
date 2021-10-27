Get-ExecutionPolicy
Set-ExecutionPolicy Unrestricted –Scope CurrentUser

#############################################
######     Import CSV File of users    ######
######     To update MFA for Accounts  ######
#############################################



#Get User Credentials and login to MS Online
$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService –Credential $UserCredential

#List MFA Users
Get-MsolUser  | Select-Object UserPrincipalName,StrongAuthenticationMethods,StrongAuthenticationRequirements 

#Import DatA from CSV file and create variable
#Import-Csv ".\mfa_gwii.csv";
$UsersArray = Import-Csv ".\mfa_gwii.csv";
#search through file and create array for Data input
foreach($user in $UsersArray)
{
    If ($user.UpdateNow -eq "Yes")
    {
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
        $st.RelyingParty = "*"
        #State can be Enforced, Enabled, Disabled
        $st.State = "Enforced"
        $sta = @($st)
        $m=@()
        #Take variables and set the state of each user
        Set-MsolUser -UserPrincipalName $user.UserEmail -StrongAuthenticationRequirements $sta
        #Make users Re-Register MFA
        set-msoluser -Userprincipalname $user.UserEmail -StrongAuthenticationMethods $m
        #Output message stating that Data in Username column has been used to update that account
        Write-Host $User.Username "has been update with a MFA state of '"$st.State"'" -ForegroundColor Yellow
     }
     Else
     {
          If($user.UpdateNow -eq "No" -and $user.mfastatus -eq "Enforced")
          {Write-Host $User.Username "MFA Status = " $User.mfastatus -ForegroundColor Green
          }
          Else
          {Write-Host $User.Username "MFA Status = " $User.mfastatus -ForegroundColor Red
          }
     }
}