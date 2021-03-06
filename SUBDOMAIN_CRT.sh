#!/bin/bash

if [ $# -eq 0 ]; then
	echo "usage: "$0 "[domain]..." >&2
	exit 1
fi

for domain in "$@"; do
	echo "Searching for: \"$domain\""

	curl -A 'Googlebot' -s 'https://crt.sh?q='$domain'&output=json' \
		| jq .[].name_value \
		| sed 's/\\n/\n/g' \
		| sed 's/"//g' \
		| sort | uniq \
		| tee -a $1.txt
done
