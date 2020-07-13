#Deprovisioning and creating a Linux custom image using Azure CLI

#Ensure we're using bash for this demo
bash

#login interactively and set a subscription to be the current active subscription
az login && az account set --subscription "Demonstration Account"

#Find the IP of the VM we want to build a custom image from.
az vm list-ip-addresses --name "linux-imagae" --output table

#Connect to the virtual machine via ssh
ssh demoadmin@w.x.y.z

#Deprovision the virtual machine
sudo waagent -deprovision+user -force

#log out of the VM
exit

#In Azure CLI, deallocate the virtual machine
az vm deallocate \
   --resource-group "Linux-imgae_group" \
    --name "linux-imagae"

#Check out the status of our virtual machine
az vm list --show-details --output table

#Mark the virtual machine as "generalized"
az vm generalize --resource-group "Linux-imgae_group" --name "linux-imagae"

#Create a VM from the custom image we just created, simply specify the image as a source.
#Defaults to LRS, add the --zone-resilient  option for ZRS if supported in your Region.
az image create --resource-group "Linux-imgae_group" --name "Linux-image" --source "linux-imagae"

#Summary image information
az image list \
    --output table

#More detailed image information, specifically this is a managed disk.
az image list

#Create a VM specifying the image we want to use
az vm create --resource-group "Linux-imgae_group" --location "germanywestcentral" --name "linux-imagaec" --image "Linux-image" --admin-username "demoadmin" --authentication-type "ssh" --ssh-key-value C:\srdev\Keys\2020-Q3-Pub.txt

#Check out the status of our provisioned VM from the Image and also our source VM is still deallocated.
az vm list \
    --show-details \
    --output table

#Try to start our generalized image, you cannot. 
#If you want to keep the source VM around...then copy the VM, generalize the copy and continue to use the source VM.
az vm start \
    --name "linux-imagae" \
   --resource-group "Linux-imgae_group"

#You can delete the deallocated source VM
az vm delete --name "linux-imagae" --resource-group "Linux-imgae_group"

#Which will leave just the Image in our Resource Group as a managed resource.
az resource list --resource-type=Microsoft.Compute/images --output table
