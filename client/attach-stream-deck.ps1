#Requires -RunAsAdministrator

param (
    [string]$poll = $false
)


Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

$remoteHost = "10.0.0.169"
$deviceId = "0fd9:0080"

while ($true) 
{
    $device = Find-Remote-Device $remoteHost $deviceId

    if (!$device) {
        Write-Host "No device found"

        if (!$poll) {
            exit 1
        }

        Start-Sleep -Seconds 5
        continue
    }

    Attach-Device $remoteHost $device.BusId
    exit 0
}