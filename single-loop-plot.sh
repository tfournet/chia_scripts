#/bin/sh 
. ~/chia-blockchain/activate

source ~/chia-blockchain/chia_scripts/global.sh


tempdir="/plots/tmp"
plotdir="/plots/final"
memsize=16384


iteration=0
while [ -d $tempdir ]; do
    iteration++
    echo "Creating plot $iteration" | tee ~/chia-blockchain/chia_scripts/chia.log
     sleep 3
    chia plots create -k $k_size -n 4 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads
    sleep 10
done


