<#
.SYNOPSIS
    This PowerShell script ensures that connections to non-domain networks when connected to a domain authenticated network are blocked. 

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-05-01
    Last Modified   : 2025-05-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000060

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000060.ps1 
#>

# Define registry path and desired setting
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"
$valueName = "fBlockNonDomain"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value, if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Check and update if necessary
if ($null -eq $currentValue -or $currentValue -ne $desiredValue) {
    Write-Output "Setting $valueName to $desiredValue..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "$valueName set successfully."
} else {
    Write-Output "$valueName is already set correctly ($currentValue)."
}
