
# Define the path to your script
$scriptPath = "$PSScriptRoot\attach-stream-deck.ps1"

# Task variables
New-ScheduledTaskAction -AsJob {}

$taskName = "Attach Stream Deck using usbip"
$action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`" -poll"
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Register the task
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal
