#!/bin/bash
crt(){
	subdom=`echo ${1:-$(</dev/stdin)}`
	read -r -a subdomArray <<< $subdom

	for subdomain in "${subdomArray[@]}"
	do
		echo -e "\e[33m[*]Getting results for $subdomain" 1>&2
		result=`curl -s   'https://crt.sh/?q='"$(echo $subdomain | tr ' ' '+')"'&output=json'  `
		echo "$result" | jq . &>/dev/null
		if [ "$?" == "0" ] ;
		then
			echo -e "\e[32m[+]Got results for $subdomain" 1>&2
			echo -n "$result"  | jq -r '.[].name_value' |sort -u | sed 's/\*\.//g' | grep '\.' | awk '{print $1}'
			sleep 0.3
		else 
			echo -e "\e[31m[-]Error occurred, trying again in 30 seconds..." 1>&2
			sleep 30
			result=`curl -s   'https://crt.sh/?q='"$(echo $subdomain | tr ' ' '+')"'&output=json' `
			echo "$result" | jq . &>/dev/null
				
			if [ "$?" == "0" ] ;
			then
				echo -e "\e[32m[+]Got results for $subdomain" 1>&2
				echo "$result"  | jq -r '.[].name_value' |sort -u | sed 's/\*\.//g' | grep '\.' | awk '{print $1}' 
				sleep 0.2
			else 
				echo -e "\e[31m[-]Failed to get results for $subdomain" 1>&2
			fi
			 	
		fi
	done
}

recur=$1
eval crt$(for i in `seq $((recur-1))`; do echo -n 'u- tros|trc.';done | tr '.' '|' | rev)
