#Requires -RunAsAdministrator

Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

$deviceId = "0fd9:0080"

$device = Find-Imported-Device $deviceId

if (!$device) {
    Write-Host "No device found"
    exit 1
}

Detach-Device $device.Port