#Requires -RunAsAdministrator

Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

$uri = "https://github.com/cezanne/usbip-win/releases/download/v0.3.6-dev/usbip-win-0.3.6-dev.zip"
$zipPath = "C:\dev\tools\usbip.zip"
$usbipDir = "C:\dev\tools\usbip"
$usbipdPath = "C:\dev\tools\usbip\usbip.exe"

Write-Host "Downloading 'usbip-win-0.3.6-dev.zip'..."
Invoke-WebRequest -Uri $uri -OutFile $zipPath

Write-Host "Extracting 'usbip-win-0.3.6-dev.zip' to '$usbipDir'..."
Expand-Archive -Path $zipPath -DestinationPath $usbipDir -Force
Remove-Item -Path $zipPath

Write-Host "Installing usbip..."
& $usbipdPath install

Add-Path $usbipDir
Reload-Path