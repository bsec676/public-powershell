#connect to AzureAD
$AZCreds = Get-Credential
Connect-AzureAD -Credential $AZCreds

Get-AzureADUser -all $true | Select DisplayName,UserPrincipalName,AccountEnable,CompanyName,Department,Jobtitle | ft

<#
The following are all the properties than can be used
AccountEnabled                  Property   System.Nullable[bool] AccountEnabled {get;set;}                                                                                                                  
AgeGroup                        Property   string AgeGroup {get;set;}                                                                                                                                       
3AssignedLicenses               Property   System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.AssignedLicense] AssignedLicenses {get;}                                                            
AssignedPlans                   Property   System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.AssignedPlan] AssignedPlans {get;}                                                                  
City                            Property   string City {get;set;}                                                                                                                                           
CompanyName                     Property   string CompanyName {get;set;}                                                                                                                                    
ConsentProvidedForMinor         Property   string ConsentProvidedForMinor {get;set;}                                                                                                                        
Country                         Property   string Country {get;set;}                                                                                                                                        
CreationType                    Property   string CreationType {get;set;}                                                                                                                                   
DeletionTimestamp               Property   System.Nullable[datetime] DeletionTimestamp {get;}                                                                                                               
Department                      Property   string Department {get;set;}                                                                                                                                     
DirSyncEnabled                  Property   System.Nullable[bool] DirSyncEnabled {get;}                                                                                                                      
DisplayName                     Property   string DisplayName {get;set;}                                                                                                                                    
ExtensionProperty               Property   System.Collections.Generic.Dictionary[string,string] ExtensionProperty {get;set;}                                                                                
FacsimileTelephoneNumber        Property   string FacsimileTelephoneNumber {get;set;}                                                                                                                       
GivenName                       Property   string GivenName {get;set;}                                                                                                                                      
ImmutableId                     Property   string ImmutableId {get;set;}                                                                                                                                    
IsCompromised                   Property   System.Nullable[bool] IsCompromised {get;set;}                                                                                                                   
JobTitle                        Property   string JobTitle {get;set;}                                                                                                                                       
LastDirSyncTime                 Property   System.Nullable[datetime] LastDirSyncTime {get;}                                                                                                                 
LegalAgeGroupClassification     Property   string LegalAgeGroupClassification {get;}                                                                                                                        
Mail                            Property   string Mail {get;}                                                                                                                                               
MailNickName                    Property   string MailNickName {get;set;}                                                                                                                                   
Mobile                          Property   string Mobile {get;set;}                                                                                                                                         
ObjectId                        Property   string ObjectId {get;}                                                                                                                                           
ObjectType                      Property   string ObjectType {get;}                                                                                                                                         
OnPremisesSecurityIdentifier    Property   string OnPremisesSecurityIdentifier {get;}                                                                                                                       
OtherMails                      Property   System.Collections.Generic.List[string] OtherMails {get;set;}                                                                                                    
PasswordPolicies                Property   string PasswordPolicies {get;set;}                                                                                                                               
PasswordProfile                 Property   Microsoft.Open.AzureAD.Model.PasswordProfile PasswordProfile {get;set;}                                                                                          
PhysicalDeliveryOfficeName      Property   string PhysicalDeliveryOfficeName {get;set;}                                                                                                                     
PostalCode                      Property   string PostalCode {get;set;}                                                                                                                                     
PreferredLanguage               Property   string PreferredLanguage {get;set;}                                                                                                                              
ProvisionedPlans                Property   System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.ProvisionedPlan] ProvisionedPlans {get;}                                                            
ProvisioningErrors              Property   System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.ProvisioningError] ProvisioningErrors {get;}                                                        
ProxyAddresses                  Property   System.Collections.Generic.List[string] ProxyAddresses {get;}                                                                                                    
RefreshTokensValidFromDateTime  Property   System.Nullable[datetime] RefreshTokensValidFromDateTime {get;}                                                                                                  
ShowInAddressList               Property   System.Nullable[bool] ShowInAddressList {get;set;}                                                                                                               
SignInNames                     Property   System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.SignInName] SignInNames {get;set;}                                                                  
SipProxyAddress                 Property   string SipProxyAddress {get;}                                                                                                                                    
State                           Property   string State {get;set;}                                                                                                                                          
StreetAddress                   Property   string StreetAddress {get;set;}                                                                                                                                  
Surname                         Property   string Surname {get;set;}                                                                                                                                        
TelephoneNumber                 Property   string TelephoneNumber {get;set;}                                                                                                                                
UsageLocation                   Property   string UsageLocation {get;set;}                                                                                                                                  
UserPrincipalName               Property   string UserPrincipalName {get;set;}                                                                                                                              
UserState                       Property   string UserState {get;set;}                                                                                                                                      
UserStateChangedOn              Property   string UserStateChangedOn {get;set;}                                                                                                                             
UserType                        Property   string UserType {get;set;} #>