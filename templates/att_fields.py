#!/bin/bash

# Have your Json data formatted like this before uploading:
# {
#     "id": "108985180",
#     "fullname": "PEDRO GONZALEZ",
#     "phones": [
#         "1111110013",
#         "9543847389"
#     ],
#     "ssn": "*0n1wqt+dx+cab/qz+zjg1/g==",
#     "dob": "*1hq+6+7wbh7k=",
#     "address": {
#         "street": "4102 SAPPHIRE TER",
#         "city": "WESTON",
#         "state": "FL",
#         "zip": "33331"
#     },
#     "address_alternative": {
#         "street": "4102 SAPPHIRE TER",
#         "city": "",
#         "state": "WESTON",
#         "zip": "FL",
#         "unit": "PEDRO GONZALEZ"
#     },
#     "email": "GONSOLPE@GMAIL.COM",
#     "metadata": {
#         "statuscode": "2",
#         "category": "CONSUMER",
#         "subcategory": "CONSUMER",
#         "unknown": "*0oRy1FbWNBmc=",
#         "flag": "0",
#         "status": "C",
#         "timestamp": "2024-11-14T02:04:34.329471"
#     }
# }


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

curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"id","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"fullname","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"phones","type":"strings"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"ssn","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"dob","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address.street","type":"text_general"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address.city","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address.state","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address.zip","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address_alternative.street","type":"text_general"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address_alternative.unit","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address_alternative.city","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address_alternative.state","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"address_alternative.zip","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"email","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.statuscode","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.category","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.subcategory","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.unknown","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.flag","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.status","type":"string"}}'
curl $auth_header "http://$ip:$port/solr/atnt/schema?wt=json" -X POST -H 'Accept: application/json' --data-raw '{"add-field":{"stored":true,"indexed":true,"name":"metadata.timestamp","type":"string"}}'
echo "done"
