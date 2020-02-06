#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`
# change below values to yours
name=diana
remotehost=10.13.200.215
remoteport=50000

while true
do
	read -p "${green}What are you going to do:
${blue}1${reset} Send a file to VM's user
${blue}2${reset} Send a ssh public key to user on VM
${blue}3${reset} Connect to user on VM
${blue}4${reset} Nothing
${green}your answer:${reset} " number
	if [ $number == 1 ]
	then
		read -p "${green} Name of the file you would like to send: ${reset}" file
		read -p "${green} to which user you want to sent file?
		${blue}1${reset} Diana
		${blue}2${reset} new user
		${green}your answer:${reset} " user
		if [ $user == 2 ]
		then
			read -p "${green} type username ${reset}" name
			read -p "${green} remotehost: ${reset}" remotehost
			read -p "${green} port: ${reset}" remoteport
		fi
		scp -P $remoteport $file $name@$remotehost:
	elif [ $number == 2 ]
	then
		read -p "${green} type username ${reset}" name
		read -p "${green} remotehost: ${reset}" remotehost
		read -p "${green} port: ${reset}" remoteport
		ssh-copy-id -i /Users/dmukaliy/.ssh/id_rsa.pub $name@$remotehost -p $remoteport
	elif [ $number == 3 ]
	then
		read -p "${green} to which user you want to connect?
		${blue}1${reset} Diana
		${blue}2${reset} new user
		${green}your answer:${reset} " user
		if [ $user == 2 ]
		then
			read -p "${green} type username ${reset}" name
			read -p "${green} remotehost: ${reset}" remotehost
			read -p "${green} port: ${reset}" remoteport
		fi
		ssh $name@$remotehost -p $remoteport
	elif [ $number == 4 ]
	then
		break
	fi
done

