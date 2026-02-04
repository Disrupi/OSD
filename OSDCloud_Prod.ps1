Write-Host -ForegroundColor Yellow "Loading OSDCloud..."

Install-Module OSD -Force -SkipPublisherCheck | Out-Null
Install-Module MSCatalog -Force -SkipPublisherCheck | Out-Null


# ==================================================
# HARD STOPS
# ==================================================

$Global:OSDCloudOffline  = $true
$Global:OSDCloudDrivers = $false

Remove-Variable -Name OSDCloudDriverPack -Scope Global -ErrorAction SilentlyContinue
Remove-Variable -Name MyOSDCloudDriverPack -Scope Global -ErrorAction SilentlyContinue
Remove-Variable -Name OSDCloudDriverSource -Scope Global -ErrorAction SilentlyContinue


# ==================================================
# MAIN CONFIG
# ==================================================

$Global:MyOSDCloud = [ordered]@{
    Restart               = $true
    RecoveryPartition     = $true
    OEMActivation         = $true

    WindowsUpdate         = $true
    WindowsUpdateDrivers  = $false
    WindowsDefenderUpdate = $true

    SyncMSUpCatDriverUSB  = $false
    updateFirmware        = $false

    SetTimeZone           = $true
    ClearDiskConfirm      = $false
    ShutdownSetupComplete = $false
    CheckSHA1             = $true
}

# THIS IS THE CRITICAL LINE
$Global:MyOSDCloud.DriverPackName = 'None'

$Global:MyOSDCloud


# ==================================================
# OS SELECTION
# ==================================================

$Params = @{
    OSVersion  = "Windows 11"
    OSBuild    = "24H2"
    OSEdition  = "Enterprise"
    OSLanguage = "en-us"
}

Start-OSDCloud @Params
