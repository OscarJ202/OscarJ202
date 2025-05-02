<#
.SYNOPSIS
    This PowerShell script ensures that the administrator accounts must not be enumerated during elevation. 

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000200

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000200.ps1 
#>

# Registry path for UAC elevation prompt behavior
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$valueName = "EnumerateAdministrators"
$desiredValue = 0  # 0 = Do NOT show list of admin accounts

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Set the value if it's missing or incorrect
if ($null -eq $currentValue -or $currentValue -ne $desiredValue) {
    Write-Output "Setting $valueName to $desiredValue..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "$valueName has been configured successfully."
} else {
    Write-Output "$valueName is already set correctly ($currentValue)."
}
