$rgName = 'Sandro-Test'

$pathPubKey = 'c:\temp\neils-ubox.pub'

$newVmName = 'psdemo-linux-2b'
$username = 'demoadmin'

$nicName = 'Neils-NIC'

$rg = Get-AzResourceGroup `
  -Name $rgName `

$rg 