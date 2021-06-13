sim_plots=6
delay=1800

tempdir="/mnt/local/plots/tmp"
plotdir="/mnt/local/plots/final"
memsize=8192
delay=1200
plotcount=6

for count in $(seq 1 $sim_plots); do
    echo "Run $count of $sim_plots"
    sleeptime=$((($count-1) * $delay))
    
    screenName="Plot$count"
    echo "Spawning session $screenName with $sleeptime second delay."
    screen -S $screenName -dm bash -c "/home/tfournet/chia-blockchain/chia_scripts/plot.sh $tempdir $plotdir $memsize $sleeptime $plotcount" 
    sleep 1
done

screen -list 

