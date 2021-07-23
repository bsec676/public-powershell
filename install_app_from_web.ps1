#Use the below to quickly download and install an applicaiton from the web if you know the application's download link.

#FrontApp Website
$app = "URL Link"

#Save On computer Destination
$destination = "$env:userprofile\Downloads\application_name.exe"

#Does this applicaiton already exsit?
$FileExists = "Directory where app exsists"


If ($FileExists -eq $True) {
#you can uncomment this if you want a pop up showing you that the application already exsists
#$wshell = New-Object -ComObject Wscript.Shell
#$wshell.popup("Front is already installed",0,"Application Installed",0)
exit
}else{
#Download Front
Invoke-WebRequest -Uri $app -OutFile $destination
#Install Front
Start-Process -Wait -ArgumentList "/silent" -PassThru -FilePath "$env:userprofile\Downloads\application_name.exe"
}

