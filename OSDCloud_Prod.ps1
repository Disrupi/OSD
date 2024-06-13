Write-Host  -ForegroundColor Yellow "Loading OSDCloud..."


Install-Module OSD -Force -Skippublishercheck | out-null
Install-Module MSCatalog -Force -Skippublishercheck | out-null


#$Global:MyOSDCloud = @{
 #   DriverPackName = 'Microsoft Update Catalog'
  #  ApplyManufacturerDrivers = $false
   # ApplyCatalogDrivers = $true
   # ApplyCatalogFirmware = $true
   # MSCatalogDiskDrivers = $true
   # MSCatalogNetDrivers = $true
   # MSCatalogScsiDrivers = $true
   # MSCatalogFirmware = $true
#}

#

$Params = @{
    OSVersion = "Windows 11"
    OSBuild = "22H2"
    OSEdition = "Enterprise"
    OSLanguage = "en-us"
    ZTI = $true
    Firmware = $true
}
#Start-OSDCloud @Params
#wpeutil reboot
