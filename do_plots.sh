#!/bin/sh

myhost=$(hostname | cut -f1 -d\.)

script="${myhost}_plot.sh"

rm -fr chia_scripts 
git clone https://github.com/tfournet/chia_scripts
sh chia_scripts/$script 

