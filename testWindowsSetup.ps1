# This is the first effort to set up installations of applications needed for Honors Windows computer 
# This script is now not used anymore but its contents and functions might be helpful in future scripts
# Such as using the setUpPublicFolder function in the new gorillaScript.ps1 with the same syntax


  
function InstallPSCore {
Write-Host "Downloading .msi file for Powershell Core..."
 
# Fix the Invoke-WebRequest access issue
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

# Fix the progress bar = slower download speed issue 
$ProgressPreference='SilentlyContinue'

# Download .msi file from hc-storage
Invoke-WebRequest -Uri "http://hc-storage.cougarnet.uh.edu/packages/PowerShell-6.2.1-win-x64.msi" -OutFile $exefilepath\PowerShell-6.2.1-win-x64.msi 

Write-Host "Installing Powershell Core..." 

Start-Process msiexec.exe -Wait -ArgumentList '/I $exefilepath\PowerShell-6.2.1-win-x64.msi /quiet'   
}


function InstallOpenSSH {
Write-Host "Enabling OpensSH Client and OpenSSH Server from settings"

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 

Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0   

Write-Host "Starting ssh and checking FireWallRule..."
# Check the firewall rule and see if it's there, doesn't have to print the whole thing out
Start-Service sshd
Get-NetFireWallRule -Name *ssh* 
}


function setUpPublicFolder {
    Write-Host "Folder created?.."
$exefilepath="C:\Users\Public\exefiles\"
if(!(Test-Path -Path $exefilepath)) {
    New-Item -Path $exefilepath -ItemType directory
    }
}


function installAcrobat {
$exefilepath="C:\Users\Public\exefiles"
$ProgressPreference='SilentlyContinue'
if(!(Test-Path -Path $exefilepath\AdobeAcrobat)) {
    New-Item -Path $exefilepath\AdobeAcrobat -ItemType directory
    }
Invoke-WebRequest -Uri "http://hc-storage.cougarnet.uh.edu/packages/Acrobat_DC_Web_WWMUI2.exe" -OutFile "$exefilepath\Acrobat_DC_Web_WWMUI.exe"

   mv 
   Expand-Archive -LiteralPath $exefilepath\Acrobat_DC_Web_WWMUI.exe -DestinationPath $exefilepath\AdobeAcrobat
#Start-Process C:\Users\Public\exefiles\Acrobat_DC_Web_WWMUI.exe /S -NoNewWindow -Wait -PassThru 

}

setUpPublicFolder

#InstallPSCore

#InstallOpenSSH

installAcrobat 
