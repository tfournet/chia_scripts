#!/bin/sh

plotdir="/mnt/plots"
me=$(whoami)

echo ';' | sudo sfdisk /dev/sdb

sudo mkfs.xfs /dev/sdb1

sudo mkdir $plotdir
sudo mount /dev/sdb1 $plotdir

sudo chown -R $me.$me $plotdir
sudo chown -R $me.$me /mnt/resource/

sh ./genplots_azure.sh 

