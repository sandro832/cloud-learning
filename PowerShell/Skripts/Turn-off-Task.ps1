# Input bindings are passed in via param block.

param($Timer)



# Get the current universal time in the default string format.

$currentUTCtime = (Get-Date).ToUniversalTime()



Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"

#>

Select-AzSubscription e67a50bc-70b2-4838-8598-c9fb1880a4ac



$vmList = Get-AzVM -Status

Foreach ($machine in $vmList) {

    #$ActiveVm = Write-Host $PowerOffVms = $machine.Name "---" $machine.PowerState "---" $machine.Tags
    # To do If Powerstate VM running
    if ($machine.PowerState -eq "VM running") {

        if ($machine.tags.ContainsKey("PowerOff")){

            Write-Host  "Found Override"  $machine.Name "---" $machine.ResourceGroupName
        }
        Else 
        {
            
            Stop-AzVM -ResourceGroupName $machine.ResourceGroupName -name $machine.name -Force -NoWait
        }
    }
}

