#Requires -RunAsAdministrator

Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

try 
{
    $deviceId = "0fd9:0080"

    Start-Transcript -Path "$PSScriptRoot\..\logs\detach-stream-deck.log"

    Write-Log "Testing remote connection..."    

    if (!(Test-Remote $remoteHost)) {
        Write-Log "  Remote host '$remoteHost' is not reachable"

        exit 1
    }

    Write-Log "Searching imported devices..."
    $device = Find-Imported-Device $deviceId

    if (!$device) {
        Write-Host "  No device found"
        exit 1
    }

    Write-Log "  Found device '$deviceId':"
        Write-Log "    Port:       $($device.Port)"
        Write-Log "    BusId:      $($device.BusId)"
        Write-Log "    VendorName: $($device.VendorName)"
        Write-Log "    DeviceName: $($device.DeviceName)"


    Write-Log "Detaching device..."
    Detach-Device $device.Port

    Write-Log "  Detached device '$deviceId'"
}
finally 
{
    Stop-Transcript
}