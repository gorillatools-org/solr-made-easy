#!/bin/bash

read -p "[+] Solr Server Path (e.g '/home/user/solr-8.9.0' (no end slash)) » " solr_bin

if [[ "$solr_bin" == */ ]]; then
  echo "Error: Solr Server Path should not end with a slash. Exiting."
  exit 1
fi

read -p "[+] Solr Collection Name » " collection
read -p "[+] Your Local IP » " host
read -p "[+] Solr's Port » " port

# Getting zookeeper port
echo "Getting zookeeper port.."
zk_port=$($solr_bin/bin/solr status | grep "ZooKeeper" | awk -F'[:,"]' '{print $6}' | head -n 1)
echo "Found ZooKeeper @ $zk_port" && [ -z "$zk_port" ] && echo "Error: ZooKeeper port not found. Exiting." && exit 1

# Copy over default configset
cd $solr_bin/server/solr/configsets/
[ ! -d "_default" ] && echo "Error: _default configset not found. Exiting!!" && exit 1
mkdir "$collection"
cp -r _default/. "$collection"
cd "$collection"

# Notify zookeeper we made a new config
$solr_bin/bin/solr zk upconfig -n "$collection" -d "$solr_bin/server/solr/configsets/$collection" -z "$host:$zk_port"

# Create collection for our data
curl "http://$host:$port/solr/admin/collections?action=CREATE&name=$collection&numShards=4&replicationFactor=1&collection.configName=$collection"

read -p "auto-generate fields based on keys in your data? (yes/no) » " schemaless

# Disable schema-less mode
if [ "$schemaless" == "yes" ]; then
    curl "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"true"}}'
elif [ "$schemaless" == "no" ]; then
    curl "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'
else
    echo "Invalid Schemaless Option. Exiting!"
    exit 1
fi
