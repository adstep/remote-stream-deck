#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

Import-Module "$PSScriptRoot\common.psm1" -Force -WarningAction Ignore

Start-Transcript -Path "$PSScriptRoot\..\attach-stream-deck.log"

try {
    $remoteHost = "10.0.0.87"
    $deviceId = "0fd9:0080"

    while ($true) 
    {
        Write-Log "Testing remote connection..."    

        if (!(Test-Remote $remoteHost)) {
            Write-Log "  Remote host '$remoteHost' is not reachable"

            Start-Sleep -Seconds 5
            continue
        }

        Write-Log "Searching for remote device..."    

        $device = Find-Remote-Device $remoteHost $deviceId

        if (!$device) {
            Write-Log  "  No device '$deviceId' found on remote host '$remoteHost'"

            $devices = Get-Remote-Devices $remote

            if ($devices.Count -gt 0)
            {
                Write-Log "  Available devices on remote host '$remoteHost':"

                foreach ($device in $devices) {
                    Write-Log  "    Device '$($device.DeviceId)' is attached to bus '$($device.BusId)'"
                }
            }

            Start-Sleep -Seconds 5
            continue
        }

        Write-Log "  Found device '$deviceId':"
        Write-Log "    Port:       $($device.Port)"
        Write-Log "    BusId:      $($device.BusId)"
        Write-Log "    VendorName: $($device.VendorName)"
        Write-Log "    DeviceName: $($device.DeviceName)"
        

        Write-Log "Attaching to device..."    
        Attach-Device $remoteHost $device.BusId

        Write-Log "  Attached device '$deviceId'"    

        $importedDevice = Find-Imported-Device $deviceId
        Write-Log "  Port: $($importedDevice.Port)"

        Write-Log "Waiting for disconnect..."
        while ($true) {
            if (!(Test-Remote $remoteHost)) {
                Write-Log "  Remote host is not reachable"
                break
            }

            Start-Sleep -Seconds 5
        }

        Write-Log "Searching imported devices..."
        $device = Find-Imported-Device $deviceId

        if (!$device) {
            Write-Log "  No device '$deviceId' found"
            continue
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
}
finally
{
    Stop-Transcript
}