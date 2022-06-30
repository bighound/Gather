#!/bin/bash

apt update -y 
apt install gobuster -y
apt install git -y
git clone https://github.com/blechschmidt/massdns.git
apt install make -y
cd massdns
make
make install
cd ..
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
./EyeWitness/Python/setup/setup.sh
sleep 1
echo '\nEnjoy hacking!!'
