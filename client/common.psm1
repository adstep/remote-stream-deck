$remoteDeviceRegex = "\s(?<busId>\d+-\d+):(?<vendorName>[^:]+):(?<deviceName>.*)\((?<deviceId>[A-Fa-f0-9]{4}:[A-Fa-f0-9]{4})\)"
$importedDeviceRegex = "Port (?<port>[\d]+):[^\n]+\n\s+(?<vendorName>[^:]+):(?<deviceName>.*)\((?<deviceId>[A-Fa-f0-9]{4}:[A-Fa-f0-9]{4})\)"

function Add-Path($path) {
    # Get the current user's PATH environment variable
    $currentUserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    # Split the PATH into an array of individual paths
    $pathArray = $currentUserPath -split ';'

    # Check if the new path already exists in the PATH
    if ($pathArray -contains $NewPath) {
        return
    } 

    # Add the new path to the user's PATH
    $updatedPath = $currentUserPath + ";" + $path

    # Set the updated PATH
    [Environment]::SetEnvironmentVariable("Path", $updatedPath, "User")
}

function Reload-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Get-Remote-Devices($remote) {
    $lines = & usbip list --remote $remote
    $devices = @()

    foreach ($line in $lines) {
        if ($line -match $remoteDeviceRegex) {
            $devices += @{
                BusId = $matches["busId"]
                VendorName = $matches["vendorName"]
                DeviceName = $matches["deviceName"]
                DeviceId = $matches["deviceId"]
            }
        }
    }

    return $devices
}

function Find-Remote-Device($remote, $deviceId) {
    $devices = Get-Remote-Devices $remote

    foreach ($device in $devices) {
        if ($device.DeviceId -eq $deviceId) {
            return $device
        }
    }

    return $null
}

function Get-Imported-Devices() {
    $output = & usbip port | Join-String -Separator "`n"
    $devices = @()

    foreach ($match in [regex]::Matches($output, $importedDeviceRegex)) {
        $devices += @{
            Port = $match.Groups["port"].Value
            VendorName = $match.Groups["vendorName"].Value
            DeviceName = $match.Groups["deviceName"].Value
            DeviceId = $match.Groups["deviceId"].Value
        }
    }

    return $devices
}

function Find-Imported-Device($deviceId) {
    $devices = Get-Imported-Devices

    foreach ($device in $devices) {
        if ($device.DeviceId -eq $deviceId) {
            return $device
        }
    }

    return $null
}

function Attach-Device($remote, $busId) {
    & usbip attach --remote $remote --busid $busId
}

function Detach-Device {
    & usbip detach -p 0
}