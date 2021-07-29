########################################################
#################   Install Teams   ####################
########################################################

#Teams Website
$teams = "https://go.microsoft.com/fwlink/p/?LinkID=869426&clcid=0x409&culture=en-us&country=US&lm=deeplink&lmsrc=groupChatMarketingPageWeb&cmpid=directDownloadWin64"

#Save On computer Destination
$destination = "$env:userprofile\Downloads\teams_windows_x64.exe"

#Download Teams
Invoke-WebRequest -Uri $teams -OutFile $destination
#Install Teams
Start-Process -Wait -ArgumentList "/silent" -PassThru -FilePath "$env:userprofile\Downloads\maxuc.exe"