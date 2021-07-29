########################################################
################# Install Software  ####################
########################################################

#FrontApp Website
$app = "https://linktoapp.com/application.exe"

#Save File to users downloads folder
$destination = "$env:userprofile\Downloads\ApplicationName.exe"

#Location of Front if already installed
$FileExists = "C:\Program Files\Application Folder\applicationName.exe"


#Check to see if the file is already installed. If it is then do not install Software
If ($FileExists -eq $True) {
#$wshell = New-Object -ComObject Wscript.Shell
#If you want a message letting you know the software is installed uncomment the below line with your message
#$wshell.popup("ApplicationName is already installed",0,"ApplicationName Installed",0)
exit
}else{
#Download Application from website and add it to the destination folder
Invoke-WebRequest -Uri $frontapp -OutFile $destination
#Once downloaded - Run the EXE file to install the programd with out any interaction
Start-Process -Wait -ArgumentList "/silent" -PassThru -FilePath "$env:userprofile\Downloads\ApplicationName.exe"
}
