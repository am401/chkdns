#!/bin/bash
#  Script to check for just the IP address of a domain
#  by Andras Marton
#  date: 8th December 2019

#  Grab domain name from cmd line argument
SITE=$1

function usage() {

cat <<- EOF
	Usage for $0:
	A valid domain name must be supplied to use this script:
	$0 example.com
EOF
}

#  CHeck if the domain is going through CloudFlare
function cloudflare() {
	
	curl -ILs $SITE | grep -i "cloudflare" &>/dev/null
	local result=$?

	if [[ $result -eq 0 ]]
	then
		printf "Domain is going through CloudFlare\n"
	fi
}

function main() {
	#  Remove protocol and trailing path info from domain
	if [[ "$SITE" == http://* ]] || [[ "$SITE" == https://* ]]
	then
		SITE=`echo $SITE | awk -F/ '{print $3}'`
		dig $SITE +short
		cloudflare
	else
		dig $SITE +short
		cloudflare
	fi
}

#  Check if an argument was passed to script
if [[ -z $1 ]]
then
	usage
	exit 1
fi

#  Check string to make sure it does not contain illegal characters
if [[ "$SITE" =~ ^[a-zA-Z0-9\.\-:/]+$ ]]
then
	#  Run the main script
	main
else
	usage
	exit 1
fi
