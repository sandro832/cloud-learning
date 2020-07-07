
# Requires storage account for boot diagnostics in same subscription, it will choose one if you don't specify

$GroupName = 'Sandro-Thuesday'
$Location  = 'westeurope'

$VnetName      = 'psdemo-vnt'
$CIDR          = '172.17.0.0/16'
$SubnetName    = 'psdemo-subnet-1'
$SubnetAddress = '172.17.1.0/24'

$PipName       = 'psdemo-pip-Windows'

$NsgName       = 'psdemo-nsg-windows'

$NicName       = 'psdemo-nic-windows'

$VmName        = 'psdemoVmWindows'
$VmSize        = 'Standard_D2_v2'

$Username      = 'demoadmin'
$WinPwd        = 'Password123412123$%^&*'

$rg = New-AzResourceGroup -Name $GroupName -Location $Location
#$rg = Get-AzResourceGroup -Name $GroupName 

$rg


$subnetConfig = New-AzVirtualNetworkSubnetConfig `
    -Name $SubnetName `
    -AddressPrefix $SubnetAddress

$subnetConfig

$vnet = New-AzVirtualNetwork `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -Name $VnetName `
    -AddressPrefix $CIDR `
    -Subnet $subnetConfig

#$vnet = Get-AzVirtualNetwork -ResourceGroupName $rg.ResourceGroupName -Name $VnetName
$vnet


$pip = New-AzPublicIpAddress `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -Name $PipName `
    -AllocationMethod Static
$pip


$rule1 = New-AzNetworkSecurityRuleConfig `
    -Name ssh-rule `
    -Description 'Allow SSH' `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 100 `
    -SourceAddressPrefix '193.134.170.35/32' `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 22

$rule1

$nsg = New-AzNetworkSecurityGroup `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -Name $NsgName `
    -SecurityRules $rule1


#$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $rg.ResourceGroupName -Name $NsgName
$nsg | more


$subnet = $vnet.Subnets | Where-Object { $_.Name -eq $SubnetName }

$nic = New-AzNetworkInterface `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -Name $NicName `
    -Subnet $subnet `
    -PublicIpAddress $pip `
    -NetworkSecurityGroup $nsg

#$nic = Get-AzNetworkInterface -ResourceGroupName $rg.ResourceGroupName -Name $NicName
$nic


$windowsVmConfig = New-AzVMConfig `
    -VMName $VmName `
    -VMSize $VmSize

$password = ConvertTo-SecureString $WinPwd -AsPlainText -Force
$windowsCred = New-Object System.Management.Automation.PSCredential ($Username, $password)

$windowsVmConfig = Set-AzVMOperatingSystem `
    -VM $windowsVmConfig `
    -Windows `
    -ComputerName $VmName `
    -Credential $windowsCred

$windowsVmConfig = Set-AzVMSourceImage `
    -VM $windowsVmConfig `
    -PublisherName 'MicrosoftWindowsServer' `
    -Offer 'WindowsServer' `
    -Skus '2016-Datacenter' `
    -Version 'latest' 

$windowsVmConfig = Add-AzVMNetworkInterface `
    -VM $windowsVmConfig `
    -Id $nic.Id 

New-AzVM `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -VM $windowsVmConfig

$MyIP = Get-AzPublicIpAddress `
    -ResourceGroupName $rg.ResourceGroupName `
    -Name $pip.Name | Select-Object -ExpandProperty IpAddress

"$Username@$MyIP"

#Uncomment, select line and press F8 to run individual command:

#Stop-AzVM -Name $newVmName -ResourceGroupName $rgName -Force -AsJob
#Start-AzVM -Name $newVmName -ResourceGroupName $rgName -AsJob
#Remove-AzVM -Name $newVmName -ResourceGroupName $rgName -Force -AsJob 



