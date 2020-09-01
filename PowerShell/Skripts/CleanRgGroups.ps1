# Input bindings are passed in via param block.

param($Timer)

# Get the current universal time in the default string format.

$currentUTCtime = (Get-Date).ToUniversalTime()

Select-AzSubscription e67a50bc-70b2-4838-8598-c9fb1880a4ac

#(Get-AzResourceGroup -Name "Sandro-Rg1").Tags

$RgList = Get-AzResourceGroup

Foreach ($ResourceItem in $RgList) {

    if ($ResourceItem.Tags -and $ResourceItem.Tags.ContainsKey("Testing"))
    {     
        Remove-AzResourceGroup -Name $ResourceItem.ResourceGroupName -Force
    }
    Else {
        "Group is nessesarry" 
    }
}
    
#$ResourceItem.Tags["Testing"]

#Remove-AzResourceGroup $Rg.ResourceGroupName 







