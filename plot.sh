#!/bin/sh

. ~/chia-blockchain/activate

source ~/chia-blockchain/chia_scripts/global.sh

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
    temp=$tempdir
    if [ $i == 1 ]; then
        temp="/mnt/ssd/"
    fi 

    chia plots create -k $k_size -n 2 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $temp -d $plotdir -r $threads | tee /tmp/chia-Plot$i.log 
    chia plots check 
done 
