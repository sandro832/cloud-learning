$resourceGroup = "Sandro-Test"
$vmName = "Linux"

# Shows all images that are available in the region
Get-AzVMSize -ResourceGroupName $resourceGroup -VMName $vmName 

$vm = Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName
$vm.HardwareProfile.VmSize = ""
Update-AzVM -VM $vm -ResourceGroupName $resourceGroup

# For updowngrade just select the upper/downer image