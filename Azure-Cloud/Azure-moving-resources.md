# Maintaining Resource Groups




https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/move-support-resources

This article lists whether an Azure resource type supports the move operation. It also provides information about special conditions to consider when moving a resource.

## Microsoft.Compute
Resource Type| Resource group | Subscription  
---|---|---|
Disks| Yes | Yes | 
Images | Yes | Yes |
Snapshots | Yes | Yes | 
SSH Public Keys | No | No |
VMs | Yes | Yes | 



## Microsoft.Storage
Resource Type| Resource group | Subscription  
---|---|---|
Storage Accounts | Yes | Yes |
Storage Acc. Blob | No | No | 



## Microsoft.Network
Resource Type| Resource group | Subscription  
---|---|---|
IP Groups| Yes | Yes | 
Loadbalacers | Yes - Basic SKI No - Standard SKU | Yes - Basic SKI No - Standard SKU |
Networkinterfaces | Yes | Yes | 
Network Security Group | Yes |Yes |
Public IP Adresse | Yes - Basic SKI No - Standard SKU | Yes - Basic SKI No - Standard SKU | 
Virtual Networks | Yes | Yes
