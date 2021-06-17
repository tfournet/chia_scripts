#!/bin/sh

source ~/chia_scripts/global.sh 

sudo dnf -y install podman-docker 

tmpdir="/mnt/local/plots/tmp/$(hostname)"
plotdir="/mnt/local/plots/final"

threads=$(( $(nproc) - 4 ))

tmpfree=$(df -m $tmpdir | tail -n 1 | awk {'print $4'})
echo "Temp Free space $tmpfree megabytes"
plotfree=$(df -m $plotdir | tail -n 1 | awk {'print $4'})
echo "Plots Free space $plotfree megabytes"

iteration=0

while [[ $tmpfree -gt 250000 && $plotfree -gt 120000 ]]; do 
  iteration=$(($iteration + 1))
  echo $Running Iteration $iteration with $threads threads. Temp Dir: $tmpdir. Plot Dir: $plotdir   
  docker run \
      -v $tmpdir:/mnt/harvester \
      -v $plotdir:/mnt/farm \
      docker.io/odelucca/chia-plotter \
      -t /mnt/harvester/ \
      -d /mnt/farm/ \
      -p $farmpool_pubkey \
      -f $farmer_pubkey \
      -r $threads
  sleep 5
done

echo "Completed. Out of free space?"
