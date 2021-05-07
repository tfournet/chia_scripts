#!/bin/sh

sudo yum install epel-release -y
sudo yum update -y

# Compiling python 3.7 is generally required on CentOS 7.7 and newer
sudo yum install gcc openssl-devel bzip2-devel zlib-devel libffi libffi-devel -y
sudo yum install libsqlite3x-devel -y

# possible that on some RHEL based you also need to install
sudo yum groupinstall "Development Tools" -y
sudo yum install python3-devel gmp-devel  boost-devel libsodium-devel -y

sudo yum install wget -y
sudo wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz
sudo tar -zxvf Python-3.7.7.tgz ; cd Python-3.7.7
me=$(whoami)
sudo chown -R $me.$me *
./configure --enable-optimizations; sudo make -j$(nproc) altinstall; cd ..

python3.7 -m venv venv
ln -s venv/bin/activate
. ./activate
pip install --upgrade pip
pip install -i https://hosted.chia.net/simple/ miniupnpc==2.1 setproctitle==1.1.10

pip install chia-blockchain