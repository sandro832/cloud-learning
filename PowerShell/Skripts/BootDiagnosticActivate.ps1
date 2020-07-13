# Dieses Skript dient zum aktivieren des Boot Diagnostic und ausserdem des erstellen eines Storage Account wo diese Abgespeichert ist. 

$accountname = "debuggtest"
$rg          = "Sandro-Thuesday"
$location    = "westeurope"
$storagetype = "StorageV2"
$security    = "Standard_LRS" 
$VmName      = "psdemoVmWindows"
$VM = Get-AzVM -ResourceGroupName $rg -Name $VmName



New-AzStorageAccount `
  -ResourceGroupName $rg `
  -Name $accountname `
  -Location $location `
  -SkuName $security `
  -Kind $storagetype
  

 Set-AzVMBootDiagnostic `
    -VM $VM `
    -Enable `
    -ResourceGroupName $rg `
    -StorageAccountName $accountname 
  
  
 Update-AzVM `
   -ResourceGroupName $rg `
    -VM $VM


Restart-AzVM `
    -ResourceGroupName $rg `
    -Name $VmName