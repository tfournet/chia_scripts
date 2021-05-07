#!/bin/sh

. ~/activate

source ./global.sh

plotcount=5

dst_svr_path="/mnt/farm"

chia init 

for i in $(seq 1 $plotcount) ; do 
    tempdir="/mnt/resource"
    plotdir="/mnt/plots"
    memsize="20000"
    k_size=32
    threads=$(nproc)

    #cmd="chia plots create -k $k_size -n 1 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads"
    #echo $cmd 
    #$cmd 
    chia plots create -k $k_size -n 1 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads

    for file in $(ls $plotdir); do
        #copycmd="rsync -e 'ssh -C -p 222' -v --remove-source-files $plotdir/$file tfournet@home.tfour.net:/mnt/farm1-1.8t/ --progress"
        #echo $copycmd
        #$copycmd
        rsync -e 'ssh -C -p 222' -v --remove-source-files $plotdir/$file tfournet@home.tfour.net:/mnt/farm1-1.8t/ &
    done
done 