sim_plots=6
delay=1800

tempdir="/plots/tmp"
plotdir="/plots/final"
memsize=8192
delay=1800

for count in $(seq 1 $sim_plots); do
    echo "Run $count of $sim_plots"
    sleeptime=$((($count-1) * $delay))
    
    echo "Spawning script $count with $sleeptime second delay."
    screen -dm bash -c "/home/tfournet/chia-blockchain/chia_scripts/vh1.sh $tempdir $plotdir $memsize $sleeptime" -S "Plot$count"  
done
