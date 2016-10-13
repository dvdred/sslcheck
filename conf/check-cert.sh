#!/bin/bash

# Number of days before deadline
forewarning=14

# Alertin Mail, address to send notification
sento=dummy@example.com


# Services list to check, uncomment and configure to download from the web.
#wget "http://some-accessible-weburl/ssl-sites-to-check.txt" -O /ssl-sites-to-check.txt

checkit() {
	SITECHECK="$1"
	PORTCHECK="$2"
	sslfulldate=$(ssl-cert-info --host $SITECHECK --port $PORTCHECK --end)
	ssldate=$(echo "$sslfulldate" | cut -f 1 -d " " | tr -d \-)
	today=$(date -d "+$forewarning days" +%Y%m%d)
	[[ "$ssldate" < "$today" ]] && ( echo "is expiring"; echo "$SITECHECK will expire $sslfulldate" | mailx -s "ERR Cert: $SITECHECK" $sento )
# Uncomment to send OK notification
#	[[ $sslwarn < $today ]] && ( echo "Ok; echo "$SITECHECK is valid till $sslfulldate" | mailx -s "OK Cert: $SITECHECK" $sento )echo 
}

readfile() {
	filename="$1"
	while read -r line
	do
	    name="$line"
	    echo "$name"
	    checkit $name
	    sleep 3
	done < "$filename"
}
readfile /ssl-sites-to-check.txt
exit 0
