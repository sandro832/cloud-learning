# In this Skript

#1 - Attach a disk to an existing VM
#2 - Resizing a disk
#3 - Removing a disk
#4 - Snapshotting an OS volume and creating a VM from snapshot

#An Ubuntu VM is needed.

#########################################################################

# 1./ Login to your Subscription via cmd.

az login --subscription ""

# 2./ Creates a new data disk with Azure CLI and attaches it to your VM. This can be done hot. 

az vm disk attach --resource-group "" --vm-name "" --disk "" --new --size-gb 25 --sku""

# 3./ Prepare the disk for usage

az vm list-ip-addresses --name "" --output table

# 4./ Connect to the vm over Jump-Host

ssh -l demoadmin wxyz

# 5./ Find the block device its in the /dev/sdc and is 25GB

lsblk ---- dmesg | grep SCI

# 6./ partition the disk with fdisk and use the follweing commands to name a new primary partitions

sudo fdisk /dev/sdc 
m
n
p
w

# 7./ Format the new patition with ext4 (Filesystem)

sudo mkfs -t ext4 /dev/sdc1

# 8./ Make a directory to mount the new disk under

sudo mkdir /data1

# 9./ Get the UUID of the Device

sudo -i blkid | grep sdc1

# 10./ Put the UUID along with some other information in the /etc/fstab so, look like this along with the mounting point and filesystem

UUID=43f43tfq3-q34-5643qt-q435qt-435-43     /data1      ext4        defaults    0 0

# 11./ Mount the volume and verify the file system is mounted. 

sudo mount -a
df -h

# 12./ Exit out of a vm

exit