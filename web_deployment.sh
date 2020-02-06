#!/bin/bash

mag=`tput setaf 5`
reset=`tput sgr0`

if  git clone https://github.com/DianaMukaliyeva/Roger-skyline-1.git; then
	echo "cloned successfull"
fi
cd Roger-skyline-1
git pull
cp index.html /var/www/html/
echo "${mag}Check your web application${reset}"