<#
.SYNOPSIS
    This PowerShell script ensures that the system must be configured to prevent IP source routing. 

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\_STIG-ID-WN10-CC-000025.ps1 
#>

# Registry path for IPv4 source routing configuration
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$valueName = "DisableIPSourceRouting"
$desiredValue = 2  # 2 = Disable source routing completely

# Ensure the registry path exists (it should already exist)
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value, if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and update if necessary
if ($null -eq $currentValue -or $currentValue -ne $desiredValue) {
    Write-Output "Setting $valueName to $desiredValue..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "$valueName has been configured successfully."
} else {
    Write-Output "$valueName is already set correctly ($currentValue)."
}
