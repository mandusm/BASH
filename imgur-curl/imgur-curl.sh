#!/bin/bash

CURL_CHECK=$(whereis curl | awk '{print $2}')
if [[ $CURL_CHECK = "" ]]; then
	echo This script requires CURL
	echo apt-get install curl or yum install curl
	exit 1
fi

if [[ $1 = "" || $2 = "" ]]; then
	echo Correct Usage imgr-curl URL Download_Directory 
	exit 1
fi
		

CURL_GET=$(curl -kL $1)
IMG_SCRAPE=$(echo $CURL_GET | grep -oE '\/\/i\.imgur.com\/\w*\.jpg') 
for url in $IMG_SCRAPE; do
	FILENAME=$(echo $url | grep -oE '\w+\.jpg')
	SMALL=$(echo $FILENAME | grep -oE '\w{2,}s\.jpg')
		if [ $SMALL ]; then
			continue
		fi
	echo Fetching $FILENAME FROM http://i.imgur.com/$FILENAME
	curl -kL http://i.imgur.com/$FILENAME -o "$2/$FILENAME" --create-dirs
done
