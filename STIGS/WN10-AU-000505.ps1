<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the security event log is at least 1024000 KB or greater.

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-04-27
    Last Modified   : 2025-04-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000505.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$regName = "MaxSize"
$regValue = 1024000

# Check if the system is configured to send audit logs to an external server
# (This part should be manually documented with the ISSO if applicable)

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $regName

# Set or update the value if necessary
if ($null -eq $currentValue -or $currentValue -lt $regValue) {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Host "Security Event Log size set to $regValue KB."
} else {
    Write-Host "Security Event Log size is already $currentValue KB, which meets or exceeds the requirement."
}
