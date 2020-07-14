#First you should do the Mount-Disk.sh
# On VM

sudo umount /data
sudo vi /etc/fstab #comment out our mount


#Resizing a disk

az vm deallocate  --resource-group "Sandro-rg1"  --name "psdemo-vm-linux"
az disk update  --resource-group "Sandro-rg1" --name "psdemo-vm-linux-disk-1a" --size-gb 100
az disk list  --output table


#az vm deallocate stopped the VM !?!

az vm start --resource-group  "Sandro-rg1"  --name "psdemo-vm-linux"

#On VM
lsblk
sudo parted /dev/sdc

 
#use print to find the size of the new disk, parition 1, resize, set the size to 107, quit
print 
resizepart
1
107GB
quit

#If you have and "XFS" file system, you should use " xfs_growfs" instead of "resize2fs" command.

 

# EXT4 ****
sudo e2fsck -f /dev/sdc1
sudo resize2fs /dev/sdc1
sudo mount /dev/sdc1 /data1
sudo vi /etc/fstab
sudo mount -a
# *********

 

# XFS ****
sudo vi /etc/fstab     #reactive mount
sudo mount -a
sudo xfs_growfs /data

 

#Verify the added space is available
df -h

 

#look closely at /data it's easy to miss, use grep
df -h  | grep data
