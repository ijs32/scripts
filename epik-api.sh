#!/bin/bash
# simple script to keep dns records ip addresses up to date
ipv4=$(curl -s 'https://api.ipify.org?format=json' | jq -r '.ip')
ipv6=$(curl -s 'https://api64.ipify.org?format=json' | jq -r '.ip')

curl -X PUT "https://usersapiv2.epik.com/v2/domains/notaguru.guru/records?SIGNATURE=${EPIK_KEY}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ 
        \"set_host_records_payload\": [
                { 
                        \"HOST\": \"*\", 
                        \"TYPE\": \"A\", 
                        \"DATA\": \"$ipv4\", 
                        \"AUX\": 0, \"TTL\": 10 
                },
                { 
                        \"HOST\": \"www\", 
                        \"TYPE\": \"A\", 
                        \"DATA\": \"$ipv4\",
                        \"AUX\": 0, 
                        \"TTL\": 10
                }, 
                { 
                        \"HOST\": \"\", 
                        \"TYPE\": \"A\", 
                        \"DATA\": \"$ipv4\",
                        \"AUX\": 0, 
                        \"TTL\": 10
                },
                {
                        \"HOST\": \"www\",
                        \"TYPE\": \"AAAA\",
                        \"DATA\": \"$ipv6\",
                        \"AUX\": 0,
                        \"TTL\": 10
                },
                { 
                        \"HOST\": \"*\",
                        \"TYPE\": \"AAAA\",
                        \"DATA\": \"$ipv6\",
                        \"AUX\": 0,
                        \"TTL\": 10
                },
                { 
                        \"HOST\": \"\",
                        \"TYPE\": \"AAAA\",
                        \"DATA\": \"$ipv6\",
                        \"AUX\": 0,
                        \"TTL\": 10
                }
        ]
}"

