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
    #setting this to disable in order to inject regkeys to disable Driver Updates in ooBE
    Restart               = $false
    RecoveryPartition     = $true
    OEMActivation         = $true

    WindowsUpdate         = $true
    WindowsUpdateDrivers  = $false
    WindowsDefenderUpdate = $true

    SyncMSUpCatDriverUSB  = $false
    #maybe have to disable this one in order to prevent drivers
    updateFirmware        = $true

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
# ==================================================
# OFFLINE REGISTRY INJECTION
# ==================================================

Write-Host -ForegroundColor Cyan "Injecting Windows Update driver block policy..."

reg load HKLM\OfflineSOFTWARE C:\Windows\System32\Config\SOFTWARE

reg add "HKLM\OfflineSOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" `
    /v ExcludeWUDriversInQualityUpdate `
    /t REG_DWORD `
    /d 1 `
    /f

reg unload HKLM\OfflineSOFTWARE

Write-Host -ForegroundColor Green "Policy injected successfully."

# Now manually reboot
Restart-Computer -Force
