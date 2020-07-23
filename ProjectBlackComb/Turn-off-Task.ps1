# Input bindings are passed in via param block.

param($Timer)

# Get the current universal time in the default string format.

$currentUTCtime = (Get-Date).ToUniversalTime()

Select-AzSubscription e67a50bc-70b2-4838-8598-c9fb1880a4ac

$vmList = Get-AzVM -Status

Foreach ($machine in $vmList) {
    if ($machine.PowerState -eq "VM running") {
        if ($machine.tags.ContainsKey("PowerOff")) {
            Write-Host  "Found Override"  $machine.Name "---" $machine.ResourceGroupName
        }
        Else {
            Stop-AzVM -ResourceGroupName $machine.ResourceGroupName -name $machine.name -Force -NoWait
        }
    }
}

