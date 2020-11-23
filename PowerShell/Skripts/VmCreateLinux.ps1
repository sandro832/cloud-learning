
# Requires storage account for boot diagnostics in same subscription, it will choose one if you don't specify

# connect-azaccount
# Set-azcontext -Subscription e67a50bc-70b2-4838-8598-c9fb1880a4ac


$GroupName = 'Sandro-Load-balance'
$Location  = 'westeurope'

$VnetName      = 'psdemo-vnt'
$CIDR          = '172.17.0.0/16'
$SubnetName    = 'psdemo-subnet-1'
$SubnetAddress = '172.17.1.0/24'

$PipName       = 'psdemo-pip-linux'

$NsgName       = 'psdemo-nsg-linux'

$NicName       = 'psdemo-nic-linux'

$VmName        = 'psdemo-vm-linux'
$VmSize        = 'Standard_D2_v2' # richtiger vm typ finden!!   D2s

$Username      = 'demoadmin'
$PathPubKey    = 'C:\srdev\Keys\2020-Q3-Pub.txt'

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


$LinuxVmConfig = New-AzVMConfig `
    -VMName $VmName `
    -VMSize $VmSize

$password = ConvertTo-SecureString 'ignorepassword123412123$%^&*' -AsPlainText -Force
$LinuxCred = New-Object System.Management.Automation.PSCredential ($Username, $password)

Set-AzVMBootDiagnostic -VM $VmName -Enable -ResourceGroupName "SandroVaults" -StorageAccountName "1bootdiagnostic"
Update-AzVM -VM $VmName

$LinuxVmConfig = Set-AzVMOperatingSystem `
    -VM $LinuxVmConfig `
    -Linux `
    -ComputerName $VmName `
    -DisablePasswordAuthentication `
    -Credential $LinuxCred


$sshPublicKey = Get-Content $pathPubKey

Add-AzVMSshPublicKey `
    -VM $LinuxVmConfig `
    -KeyData $sshPublicKey `
    -Path "/home/$Username/.ssh/authorized_keys"

$LinuxVmConfig = Set-AzVMSourceImage `
    -VM $LinuxVmConfig `
    -PublisherName 'Canonical' `
    -Offer 'UbuntuServer' `
    -Skus '18.04' `
    -Version 'latest' 

$LinuxVmConfig = Add-AzVMNetworkInterface `
    -VM $LinuxVmConfig `
    -Id $nic.Id 

New-AzVM `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -VM $LinuxVmConfig

$MyIP = Get-AzPublicIpAddress `
    -ResourceGroupName $rg.ResourceGroupName `
    -Name $pip.Name | Select-Object -ExpandProperty IpAddress

"$Username@$MyIP"

#Uncomment, select line and press F8 to run individual command:

#Stop-AzVM -Name $newVmName -ResourceGroupName $rgName -Force -AsJob
#Start-AzVM -Name $newVmName -ResourceGroupName $rgName -AsJob
#Remove-AzVM -Name $newVmName -ResourceGroupName $rgName -Force -AsJob 



