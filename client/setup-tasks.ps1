
# Define the path to your script
$scriptPath = "$PSScriptRoot\attach-stream-deck.ps1"

# Task variables
New-ScheduledTaskAction -AsJob {}

$taskName = "Attach Stream Deck using usbip"
$taskDescription = "Attaches the Elgato Stream Deck to the local machine using usbip"
$action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""
git$trigger = New-ScheduledTaskTrigger -AtStartup

# Register the task
Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Action $action -Trigger $trigger -User $env:USERNAME -RunLevel Highest