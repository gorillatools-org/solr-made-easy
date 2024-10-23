#!/bin/bash

# Authentication setup
read -p "[+] Is authentication enabled? (y/N) » " auth_enabled
auth_enabled=${auth_enabled,,}

auth_header=""
if [[ "$auth_enabled" == "y" ]]; then
    read -p "[+] Enter username » " username
    read -p "[+] Enter password » " password
    auth_header="-u $username:$password"
fi

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
if [[ "$auth_enabled" == "y" ]]; then
    zk_port=$($solr_bin/bin/solr status $auth_header | grep "ZooKeeper" | awk -F'[:,"]' '{print $6}' | head -n 1)
else
    zk_port=$($solr_bin/bin/solr status | grep "ZooKeeper" | awk -F'[:,"]' '{print $6}' | head -n 1)
fi
echo "Found ZooKeeper @ $zk_port" && [ -z "$zk_port" ] && echo "Error: ZooKeeper port not found. Exiting." && exit 1

# Copy over default configset
cd $solr_bin/server/solr/configsets/
[ ! -d "_default" ] && echo "Error: _default configset not found. Exiting!!" && exit 1

# Remove existing collection directory if it exists because solr will be a bitch about it
if [ -d "$collection" ]; then
    echo "Collection directory already exists. Removing..."
    rm -rf "$collection"
fi

mkdir "$collection"
cp -r _default/. "$collection"
cd "$collection"

# Notify zookeeper we made a new config
if [[ "$auth_enabled" == "y" ]]; then
    $solr_bin/bin/solr zk upconfig -n "$collection" -d "$solr_bin/server/solr/configsets/$collection" -z "$host:$zk_port" $auth_header
else
    $solr_bin/bin/solr zk upconfig -n "$collection" -d "$solr_bin/server/solr/configsets/$collection" -z "$host:$zk_port"
fi

echo "Creating collection with 4 shards..." # you may edit the shard count before running script
if [[ "$auth_enabled" == "y" ]]; then
    curl $auth_header "http://$host:$port/solr/admin/collections?action=CREATE&name=$collection&numShards=4&replicationFactor=1&collection.configName=$collection&maxShardsPerNode=4"
else
    curl "http://$host:$port/solr/admin/collections?action=CREATE&name=$collection&numShards=4&replicationFactor=1&collection.configName=$collection&maxShardsPerNode=4"
fi

read -p "auto-generate fields based on keys in your data? (yes/[NO]) » " schemaless
schemaless=${schemaless:="no"}

# Disable schema-less mode
if [ "$schemaless" == "yes" ]; then
    if [[ "$auth_enabled" == "y" ]]; then
        curl $auth_header "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"true"}}'
    else
        curl "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"true"}}'
    fi
elif [ "$schemaless" == "no" ]; then
    if [[ "$auth_enabled" == "y" ]]; then
        curl $auth_header "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'
    else
        curl "http://$host:$port/solr/$collection/config" -d '{"set-user-property": {"update.autoCreateFields":"false"}}'
    fi
else
    echo "Invalid Schemaless Option. Exiting!"
    exit 1
fi
