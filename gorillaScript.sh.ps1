

# Windows Merged Restore


function setUpPublicFolder {

$gorillaFolder="C:\ProgramData\gorilla"
if(!(Test-Path -Path $gorillaFolder)) {
    Write-Host "'gorilla' folder is not detected. Creating a new ProgramData\gorilla folder..."
    New-Item -Path $gorillaFolder -ItemType directory
    }
else {
    Write-Host "ProgramData\gorilla folder exists..."
     }
}

function gorillaInitialSetup {

# Fix the Invoke-WebRequest access issue
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

    Write-Host "Downloading gorilla.exe file..."
   

    Invoke-WebRequest -Uri "https://github.com/1dustindavis/gorilla/releases/download/v1.0.0-beta.3/gorilla.exe" -OutFile "C:\ProgramData\gorilla\gorilla.exe"

    Write-Host "Downloading config.yaml file..."

    Invoke-WebRequest "http://hc-storage.cougarnet.uh.edu/gorilla/config.yaml" -OutFile "C:\ProgramData\gorilla\config.yaml"
    }

function AcrobatSerial {
Write-Host " "
Write-Host "Copy this following serial number to plug in Acrobat's installer later: "
Write-Host "1118-1400-4530-9867-2124-8265"
Write-Host " "
}


function InstallOpenSSH {
Write-Host " - - - "
Write-Host " "
Write-Host "Enabling OpensSH Client and OpenSSH Server from settings"

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 

Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0   

Write-Host " "
Write-Host "Starting ssh and checking FireWallRule..."
# Check the firewall rule and see if it's there, doesn't have to print the whole thing out
Start-Service sshd
Get-NetFireWallRule -Name *ssh* 
}

setUpPublicFolder

gorillaInitialSetup

AcrobatSerial

InstallOpenSSH

cd C:\ProgramData\gorilla 

.\gorilla.exe -v
