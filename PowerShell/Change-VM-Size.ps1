$resourceGroup = "Sandro-Test"
$vmName = "Linux"

Get-AzVMSize -ResourceGroupName $resourceGroup -VMName $vmName 

$vm = Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName
$vm.HardwareProfile.VmSize = "Standard_D2s_v3"
Update-AzVM -VM $vm -ResourceGroupName $resourceGroup
