#/bin/sh 
. ~/chia-blockchain/activate

source ~/chia-blockchain/chia_scripts/global.sh


tempdir="/mnt/farm2-2.7t/tmp/$(hostname)"
plotdir="/mnt/farm1-1.8t/"
memsize=3384
threads=1
k_size=32

mkdir -p $tempdir 

iteration=0
while [ ! -f /stop-plotting ]; do
    iteration=$(($iteration + 1))
    echo "Creating plot $iteration" | tee ~/chia-blockchain/chia_scripts/chia.log
     sleep 3
    chia plots create -k $k_size -n 2 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads
    sleep 10
done


