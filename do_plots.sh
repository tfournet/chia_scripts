#!/bin/sh

myhost=$(hostname | cut -f1 -d\.)

script="${myhost}_plot.sh"

curl https://github.com/tfournet/chia_scripts/$script | sh 
