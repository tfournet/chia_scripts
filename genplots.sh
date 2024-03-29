#!/bin/sh

. ~/activate

source global.sh

plotcount=1
tempdir="/tmp"
plotdir="/"
memsize="20000"
k_size=32
threads="2"

cmd="chia plots create -k $k_size -n $plotcount -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads"
$cmd 

