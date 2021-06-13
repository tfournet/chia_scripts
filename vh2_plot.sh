#!/bin/sh

source ~/chia_scripts/global.sh 

sudo dnf -y install podman-docker 

tmpdir="/var/lib/plots/tmp"
plotdir="/mnt/chia_farm1/$(hostname)"

threads=$(nproc)

tmpfree=$(df -m $tmpdir | tail -n 1 | awk {'print $4'})
plotfree=$(df -m $plotdir | tail -n 1 | awk {'print $4'})

iteration=0

while [[ $tmpfree -gt 250000 && $plotfree -gt 120000 ]]; do 
  iteration=$(($iteration + 1))
  echo $Running Iteration $iteration 
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
