$ErrorActionPreference = "Stop"

# Define the path to your script
$attachScriptPath = "$PSScriptRoot\attach-stream-deck.ps1"

# Task variables
$taskName = "Attach Stream Deck using usbip"
$taskDescription = "Attaches the Elgato Stream Deck to the local machine using usbip"
$action = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$attachScriptPath`""
$trigger = New-ScheduledTaskTrigger -AtLogOn

# Register the task
Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Action $action -Trigger $trigger -User $env:USERNAME -RunLevel Highest | Out-Null

Write-Host "Created scheduled task '$taskName' to run as '$env:USERNAME' on startup"