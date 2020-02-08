#!/bin/bash

# <!-- Author : Dipaditya Das. | Contact : www.github.com/DipadityaDas --> 

echo "Choose the Firefox release you wanna install/upgrade [1|2|3|4|5]:"
echo "1. Firefox Stable"
echo "2. Firefox Beta"
echo "3. Firefox Extended Support Release"
echo "4. Firefox Nightly"
echo "5. Firefox Developer Edition"
read -p "> " CHOICE

if uname -a | grep -w i686 ; then 
	ARCHI="i686"
	ARCHI_SHORT=""
else
	ARCHI="x86_64"
	ARCHI_SHORT="64"
fi

echo $ARCHI_SHORT

if [ $CHOICE = 1 ]; then
	RELEASE=""
elif [ $CHOICE = 2 ]; then
	RELEASE="-beta"
elif [ $CHOICE = 3 ]; then
	RELEASE="-esr"
elif [ $CHOICE = 4 ]; then
	RELEASE="-nightly"
elif [ $CHOICE = 5 ]; then
	RELEASE="-devedition"
else
	exit
fi

URL=$(wget -q -O - https://www.mozilla.org/en-US/firefox/all | egrep -o "href=.*?product=firefox$RELEASE-latest-ssl&amp;os=linux$ARCHI_SHORT&amp;lang=en-US" | sed -e 's/\&amp;/\&/g' -e 's/^href=\"//')

echo $URL

if [ ! -d "/tmp/ff$RELEASE" ] ; then
	mkdir /tmp/ff$RELEASE
else
	rm -rf /tmp/ff$RELEASE/*
fi

if [ ! -d "/opt/firefox$RELEASE" ] 
then
	sudo mkdir /opt/firefox$RELEASE
fi

wget $URL -O /tmp/ff$RELEASE/ff$RELEASE.tar.bz2
sudo tar -C /opt/firefox$RELEASE/ -xvjf /tmp/ff$RELEASE/*.tar.bz2

if [ ! -f "/usr/local/bin/firefox$RELEASE" ] 
then
	sudo ln -s /opt/firefox$RELEASE/firefox/firefox /usr/local/bin/firefox$RELEASE
fi
