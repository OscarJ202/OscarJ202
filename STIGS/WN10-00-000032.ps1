<#
.SYNOPSIS
    This PowerShell script ensures that the BinLocker PIN is a minimum lemgth of six digits for pre-boot authentication. 

.NOTES
    Author          : Oscar Jara
    LinkedIn        : linkedin.com/in/oscarjara202/
    GitHub          : github.com/OscarJ202
    Date Created    : 2025-05-01
    Last Modified   : 2025-05-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000032

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-00-000032.ps1 
#>

# Set the desired minimum PIN length
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
$valueName = "MinimumPIN"
$minPINLength = 6

# Check if the registry path exists, if not create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if necessary
if ($null -eq $currentValue -or $currentValue -lt $minPINLength) {
    Write-Output "Setting MinimumPIN to $minPINLength..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $minPINLength -Type DWord
    Write-Output "MinimumPIN set successfully."
} else {
    Write-Output "MinimumPIN is already set correctly ($currentValue)."
}
