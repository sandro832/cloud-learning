$resourceGroup = "Sandro-Test"
$vmName = "Linux"

Get-AzVMSize -ResourceGroupName $resourceGroup -VMName $vmName 

$vm = Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName
$vm.HardwareProfile.VmSize = "Standard_DS3_v2"
Update-AzVM -VM $vm -ResourceGroupName $resourceGroup
