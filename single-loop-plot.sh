#/bin/sh 


tempdir="/plots/tmp"
plotdir="/plots/final"
memsize=8192
delay=1800
plotcount=6

iteration=0
while [ -d $tempdir ]; do
    iteration++
    echo "Creating plot $iteration"
     sleep 3
    chia plots create -k $k_size -n 2 -b $memsize -f $farmer_pubkey -p $farmpool_pubkey -t $tempdir -d $plotdir -r $threads
    sleep 10
done


