#!/bin/sh

poolKey="90122d252317993b96edc1843976e93d4b6d4dcd30abb73b1ea4a2015439b42c907cf39376aa653981215cc3b3991784"
contract="xch1a7tt4nzv79yxazt45r4ft5wpe7px0xqse6xmzy2rkqsguq2kd7zsh5hytd"
farmerKey="aab5584f280e53b6fe16648d952eb7f14c6e922a535eba364d9ef4ea09031855aa6b245827a5de9a20f19685d0eeeccc"


threads=$(nproc)

host=$(hostname -s)
case  $host in 
  tf-r720)
    tmpPath="/opt/local-farm/tmp/$host/"
    tmpPath2=$tmpPath
    plotPath="/opt/local-farm/spacepool/final/"
    threads=6
    ;;
  r720-san-access-01)
    tmpPath2="/mnt/chia_farm1/tmp/$host/"
    tmpPath="/mnt/chia_farm2/tmp/$host/"
    plotPath="/mnt/chia_farm1/spacepool/final/"
    ;; 
  plotter)
    tmpPath="/mnt/chia_farm1/tmp/$host/"
    tmpPath2="/mnt/chia_farm2/tmp/$host/"
    plotPath="/mnt/chia_farm2/spacepool/final/"
    ;; 
  tf-ml350p)
    threads=20
    tmpPath="/var/lib/plots/tmp/"
    tmpPath2=$tmpPath
    plotPath="/mnt/chia_farm2/spacepool/final/"
esac

echo $host 
echo "Using $threads CPU Threads"
echo "Plotting to $plotPath"
echo "Temporary directories $tmpPath and $tmpPath2"



mkdir -p $tmpPath 
mkdir -p $tmpPath2
mkdir -p $plotPath 
rpm -q cmake || sudo dnf -y install cmake 

cd ~
#. ./activate 


if [[ ! -d ~/madmax ]]; then
  mkdir -p ~/madmax
fi 

cd ~/madmax

if [[ ! -d ./chia-plotter ]]; then
  git clone https://github.com/madMAx43v3r/chia-plotter 
fi 

cd chia-plotter 
git checkout master
git pull
git submodule update --init
./make_devel.sh

tmpfree=$(df -m $tmpPath2 | tail -n 1 | awk {'print $4'})
echo -e "\n\n\nTemp Free space $tmpfree megabytes"
plotfree=$(df -m $plotPath | tail -n 1 | awk {'print $4'})
echo "Plots Free space $plotfree megabytes"

iteration=0

while [[ $tmpfree -gt 250000 && $plotfree -gt 120000 ]]; do 
  iteration=$(($iteration + 1))
  echo "Running iteration $iteration"
  ./build/chia_plot -n 1 -r $threads -t $tmpPath -2 $tmpPath2 -G -d $plotPath --waitforcopy -c $contract -f $farmerKey
  tmpfree=$(df -m $tmpPath | tail -n 1 | awk {'print $4'})
  echo -e "\n\n\nTemp Free space $tmpfree megabytes"
  plotfree=$(df -m $plotPath | tail -n 1 | awk {'print $4'})
  echo "Plots Free space $plotfree megabytes"
done
