#!/bin/bash

# Meant for NationalPublicData template. Modify variables/values as needed

read -p "[+] Is authentication enabled? (y/N) » " auth_enabled
auth_enabled=${auth_enabled,,}

auth_header=""
if [[ "$auth_enabled" == "y" ]]; then
    read -p "[+] Enter username » " username
    read -p "[+] Enter password » " password
    auth_header="-u $username:$password"
fi

read -p "[+] Solr IP: " ip
read -p "[+] Solr Port: " port

curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"ID","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"firstname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"lastname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"middlename","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"name_suff","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"dob","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address","type":"text_general"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"city","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"county_name","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"st","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"zip","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"phone1","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"aka1fullname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"aka2fullname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"aka3fullname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"StartDat","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"alt1DOB","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"alt2DOB","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"alt3DOB","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/npd/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"ssn","type":"string"}}'
echo "done"
