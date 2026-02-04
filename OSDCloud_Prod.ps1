Write-Host -ForegroundColor Yellow "Loading OSDCloud..."

Install-Module OSD -Force -SkipPublisherCheck | Out-Null
Install-Module MSCatalog -Force -SkipPublisherCheck | Out-Null


# ==================================================
# HARD STOPS — must be set BEFORE MyOSDCloud
# ==================================================

# Absolute driver kill switch (vendor + catalog + WU)
$Global:OSDCloudDrivers = $false

# Prevent any online content (OS, drivers, firmware)
$Global:OSDCloudOffline = $true

# Defensive cleanup in case WinPE session had state
Remove-Variable -Name OSDCloudDriverPack -Scope Global -ErrorAction SilentlyContinue
Remove-Variable -Name MyOSDCloudDriverPack -Scope Global -ErrorAction SilentlyContinue
Remove-Variable -Name OSDCloudDriverSource -Scope Global -ErrorAction SilentlyContinue


# ==================================================
# Main OSDCloud configuration
# ==================================================

$Global:MyOSDCloud = [ordered]@{
    Restart                  = $true
    RecoveryPartition        = $true
    OEMActivation            = $true

    WindowsUpdate            = $true
    WindowsUpdateDrivers     = $false
    WindowsDefenderUpdate    = $true

    SyncMSUpCatDriverUSB     = $false
    DriverPack               = $null

    # IMPORTANT: firmware updates can re-trigger OEM logic
    updateFirmware           = $false

    SetTimeZone              = $true
    ClearDiskConfirm         = $false
    ShutdownSetupComplete    = $false
    CheckSHA1                = $true
}

$Global:MyOSDCloud


# ==================================================
# OS selection — local media only
# ==================================================

$Params = @{
    OSVersion  = "Windows 11"
    OSBuild    = "24H2"
    OSEdition  = "Enterprise"
    OSLanguage = "en-us"
    # ZTI = $true
}

Start-OSDCloud @Params
