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
    OSVersion = "Windows 11"
    OSBuild = "24H2"
    OSEdition = "Enterprise"
    OSLanguage = "en-us"
    Restart = [bool]$True
    RecoveryPartition = [bool]$true
    OEMActivation = [bool]$True
    WindowsUpdate = [bool]$true
    WindowsUpdateDrivers = [bool]$true
    WindowsDefenderUpdate = [bool]$true
    SetTimeZone = [bool]$true
    ClearDiskConfirm = [bool]$False
    ShutdownSetupComplete = [bool]$false
    SyncMSUpCatDriverUSB = [bool]$true
    updateFirmware = [bool]$true
    CheckSHA1 = [bool]$true
}

#for all devices
$Global:MyOSDCloud.DriverPackName = 'Microsoft Update Catalog'

#for lenovo
#$Global:MyOSDCloud.DriverPackName = 'lenovo'



$Global:MyOSDCloud

#$Params = @{
   # OSVersion = "Windows 11"
   # OSBuild = "23H2"
   # OSEdition = "Enterprise"
  #  OSLanguage = "en-us"
    #ZTI = $true
    #Firmware = $false
#}
Start-OSDCloud #@Params
#wpeutil reboot
#start-osdcloudgui
