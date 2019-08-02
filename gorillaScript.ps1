

# this function sets up a new folder in Users called Public to house all the downloaded files


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

function gorillaInitial {

# Fix the Invoke-WebRequest access issue
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

    Write-Host "Downloading gorilla.exe file..."
   

    Invoke-WebRequest -Uri "https://github.com/1dustindavis/gorilla/releases/download/v1.0.0-beta.3/gorilla.exe" -OutFile "C:\ProgramData\gorilla\gorilla.exe"

    Write-Host "Downloading config.yaml file..."

    Invoke-WebRequest "http://hc-storage.cougarnet.uh.edu/gorilla/config.yaml" -OutFile "C:\ProgramData\gorilla\config.yaml"
    }

function AcrobatSerial {

Write-Host "Copy this following serial number to plug in Acrobat's installer later: "
Write-Host "1118-1400-4530-9867-2124-8265"
}

setUpPublicFolder

gorillaInitial

AcrobatSerial


cd C:\ProgramData\gorilla 

.\gorilla.exe -v
