sim_plots=12

tempdir="/var/lib/plots/tmp"
plotdir="/var/lib/plots/final"
memsize=8192
delay=900
plotcount=6

which screen || dnf -y install screen 

mkdir -p $tempdir
mkdir -p $plotdir 

for count in $(seq 1 $sim_plots); do
    echo "Run $count of $sim_plots"
    sleeptime=$((($count-1) * $delay))
    
    screenName="Plot$count"
    echo "Spawning session $screenName with $sleeptime second delay."
    screen -S $screenName -dm bash -c "/home/tfournet/chia-blockchain/chia_scripts/plot.sh $tempdir $plotdir $memsize $sleeptime $plotcount" 
    sleep 1
done

screen -list 

