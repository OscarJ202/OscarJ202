<#
.SYNOPSIS
    This PowerShell script ensures that the Windows dialog box title for the legal banner must be configured. 

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-05-01
    Last Modified   : 2025-05-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000080

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000080.ps1 
#>

# Define registry path and desired setting
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "LegalNoticeCaption"
$desiredCaption = "DoD Notice and Consent Banner"  # Change if using a site-defined equivalent

# Ensure the registry path exists (normally does)
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if necessary
if ($null -eq $currentValue -or $currentValue -ne $desiredCaption) {
    Write-Output "Setting $valueName to '$desiredCaption'..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredCaption -Type String
    Write-Output "$valueName set successfully."
} else {
    Write-Output "$valueName is already set correctly ('$currentValue')."
}
