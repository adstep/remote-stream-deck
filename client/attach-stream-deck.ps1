#Requires -RunAsAdministrator

Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

$remoteHost = "10.0.0.169"
$deviceId = "0fd9:0080"

$device = Find-Remote-Device $remoteHost $deviceId

if (!$device) {
    Write-Host "No device found"
    exit 1
}

Attach-Device $remoteHost $device.BusId