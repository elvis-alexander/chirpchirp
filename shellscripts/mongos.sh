#!/usr/bin/env bash

# chmod +x mongos.sh
# USAGE: ./mongos.sh {shard1_ip} {shard1_port} {shard2_ip} {shard2_port} {shard3_ip} {shard3_port} {shard4_ip} {shard4_port}

# script variables
seperator="---------------------"
host_ip=$1
config_ip=$2
config_port=$3
sleep_limit=5
mongos_js="https://raw.githubusercontent.com/elvis-alexander/chirpchirp/master/shellscripts/js/mongos.js"
shard1_ip=$1
shard1_port=$2
shard2_ip=$3
shard2_port=$4
shard3_ip=$5
shard3_port=$6
shard4_ip=$7
shard4_port=$8

# installing mongodb
echo $seperator "Installing MongoDB" $seperator
sleep $sleep_limit
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
sudo echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# creating directories
echo $seperator "Creating config directories" $seperator
sleep $sleep_limit
mkdir mongo
mkdir mongo/mongo_logs

# configuring mongos
echo $seperator "Running Mongos" $seperator
sleep $sleep_limit
mongos --configdb conf/$config_ip:$config_port --bind_ip $host_ip --port 27017 --logpath /home/ubuntu/mongo/mongo_logs/mongos.log --logappend --fork
#mongos --configdb conf/192.168.1.39:27030 --bind_ip 192.168.1.32 --port 27017 --logpath /home/ubuntu/mongo/mongo_logs/mongos.log --logappend --fork

# retrieving js file
echo $seperator "Wget js file" $seperator
sleep $sleep_limit
wget $mongos_js

# setting shard data
echo $seperator "Setting up config file..." $seperator
sleep 2
sed -ie 's/shard1_ip/'$shard1_ip'/g' mongos.js
sed -ie 's/shard1_port/'$shard1_port'/g' mongos.js
sed -ie 's/shard2_ip/'$shard2_ip'/g' mongos.js
sed -ie 's/shard2_port/'$shard2_port'/g' mongos.js
sed -ie 's/shard3_ip/'$shard3_ip'/g' mongos.js
sed -ie 's/shard3_port/'$shard3_port'/g' mongos.js
sed -ie 's/shard4_ip/'$shard4_ip'/g' mongos.js
sed -ie 's/shard4_port/'$shard4_port'/g' mongos.js

# connect mongo client
echo $seperator "Feeding js input" $seperator
sleep $sleep_limit
mongo --host $host_ip --port 27017 < mongos.js
sleep 20

# mongo ps results
echo $seperator "ps results" $seperator
sleep $sleep_limit
ps -ax | grep mongo