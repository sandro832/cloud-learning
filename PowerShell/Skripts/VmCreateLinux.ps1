
# Will Create a Ubuntu Linux VM

# Assumptions:
#  1. You have a already created a Resource Group, Network Interface, Network Security Group and Public IP.
#  2. That you have associated the Public IP with the Network Interface.
#  3. You have a storage account setup in the resource group.
#  4. You have a SSH key for remote desktop.

#Connect-AzAccount -SubscriptionId 'e67a50bc-70b2-4838-8598-c9fb1880a4ac'

$rgName = 'sandro-test'
$location = "westeurope"
$pathPubKey = 'C:\srdev\Keys\2020-Q3-Pub.txt'

$newVmName = 'psdemo-linux-2b'
$username = 'demoadmin'

$nicName = 'Sandro-NIC'
$VnetName      = 'psdemo-vnt'
$CIDR          = '172.17.0.0/16'
$SubnetAddress = '172.17.1.0/24'
$SubnetName    = 'psdemo-subnet-1'
$PipName       = 'psdemo-pip-linux'
$NsgName       = 'psdemo-nsg-linux'
$NicName       = 'psdemo-nic-linux'

 

$VmName        = 'psdemo-vm-linux'
$VmSize        = 'Standard_D2_v2'

 

$Username      = 'demoadmin'
$PathPubKey    = 'C:\srdev\Keys\2020-Q3-Pub.txt'



$rg = New-AzResourceGroup -Name $rgName -location $location

#$rg = Get-AzResourceGroup -Name $rgName
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
    -ResourceGroupName $rgName `
    -Location $location `
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
    -SourceAddressPrefix 193.134.170.35/32 `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 22

$rule1


$nsg = New-AzNetworkSecurityGroup `
    -ResourceGroupName $rgName`
    -Location $location `
    -Name $NsgName `
    -SecurityRules $rule1

#$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $rg.ResourceGroupName -Name $NsgName
$nsg




