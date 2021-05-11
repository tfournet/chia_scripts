#!/bin/sh

. /home/tfournet/chia-blockchain/activate

source /home/tfournet/chia-blockchain/chia_scripts/global.sh

tempdir=$1
plotdir=$2
memsize=$3
delay=$4
plotcount=$5
k_size=32
threads=2


#chia init 
date
echo "Sleeping $delay seconds"
sleep $delay 
date

for i in $(seq 1 $plotcount) ; do 
    chia plots create -k $k_size -n 2 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads
    chia plots check 
done 
