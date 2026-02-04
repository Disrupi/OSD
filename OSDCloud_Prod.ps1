#New-OSDCloudUSB -fromIsoFile C:\ProgramData\OSDCloud\Templates\prod_v3\OSDCloud_NoPrompt.iso
Write-Host  -ForegroundColor Yellow "Loading OSDCloud..."


Install-Module OSD -Force -Skippublishercheck | out-null
Install-Module MSCatalog -Force -Skippublishercheck | out-null
#########
#########

#$Global:MyOSDCloud = @{
   # DriverPackName = 'Microsoft Update Catalog'
   # ApplyManufacturerDrivers = $false
   # ApplyCatalogDrivers = $true
   # ApplyCatalogFirmware = $true
   # MSCatalogDiskDrivers = $true
   # MSCatalogNetDrivers = $true
   # MSCatalogScsiDrivers = $true
   # MSCatalogFirmware = $true
#}

$Global:MyOSDCloud = [ordered]@{
    Restart = [bool]$True
    RecoveryPartition = [bool]$true
    OEMActivation = [bool]$True
    WindowsUpdate = [bool]$true
    #WindowsUpdateDrivers = [bool]$true
    WindowsUpdateDrivers = [bool]$false
    WindowsDefenderUpdate = [bool]$true
    SetTimeZone = [bool]$true
    ClearDiskConfirm = [bool]$False
    ShutdownSetupComplete = [bool]$false
    SyncMSUpCatDriverUSB = [bool]$false
    updateFirmware = [bool]$true
    CheckSHA1 = [bool]$true
}

#for all devices
#$Global:MyOSDCloud.DriverPackName = 'Microsoft Update Catalog'

#for lenovo
#$Global:MyOSDCloud.DriverPackName = 'Lenovo'

$Global:OSDCloudDrivers = $false
$Global:OSDCloudOffline = $true
$Global:MyOSDCloud

$Params = @{
    OSVersion = "Windows 11"
    OSBuild = "24H2"
    OSEdition = "Enterprise"
    OSLanguage = "en-us"
    #ZTI = $true
    #Firmware = $false
}
Start-OSDCloud @Params
#wpeutil reboot
#start-osdcloudgui
