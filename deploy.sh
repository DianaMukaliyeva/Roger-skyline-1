#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

while true
do
	read -p "${green}What are you going to do:
${blue}1${reset} Send a file to VM's user
${blue}2${reset} Send a ssh public key to user on VM
${blue}3${reset} Connect to user on VM
${blue}4${reset} I am on VM and want to continue
${blue}5${reset} I want to set up my Debian
${blue}6${reset} Exit
" number

	if [ $number == 1 ]
	then
		read -p "${green} Name of the file you would like to send: ${reset}" file
		read -p "${green} type username ${reset}" name
		read -p "${green} remotehost: ${reset}" remotehost
		read -p "${green} port: ${reset}" remoteport
		scp -P $remoteport $file $name@$remotehost:
	elif [ $number == 2 ]
	then
		read -p "${green} type username ${reset}" name
		read -p "${green} remotehost: ${reset}" remotehost
		read -p "${green} port: ${reset}" remoteport
		ssh-copy-id -i /Users/dmukaliy/.ssh/id_rsa.pub $name@$remotehost -p $remoteport
	elif [ $number == 3 ]
	then
		read -p "${green} type username ${reset}" name
		read -p "${green} remotehost: ${reset}" remotehost
		read -p "${green} port: ${reset}" remoteport
		ssh $name@$remotehost -p $remoteport
	elif [ $number == 4 ]
	then
		while true
		do
			echo "
	${green}Which part do you want to check?
	${blue}1${reset} VM part
	${blue}2${reset} Network and Security Part
	${blue}3${reset} Web Part
	${blue}4${reset} Exit"
			read part
			if [ $part == 1 ]
			then
			while true
			do
				echo "
		${green}What do you want to do?
		${blue}1${reset} check disk size
		${blue}2${reset} check partition
		${blue}3${reset} check if packages are uptodate
		${blue}4${reset} check if packages contain
		${blue}5${reset} exit"
				read check
					if [ $check == 1 ]
					then
						tput setaf 3
						sudo fdisk -l
					elif [ $check == 2 ]
					then
						tput setaf 3
						sudo df -h --total
					elif [ $check == 3 ]
					then
						tput setaf 3
						sudo apt list --upgradable
					elif [ $check == 4 ]
					then
						read -p "${green} type name of package you want to check ${reset}" package
						tput setaf 3
						sudo apt list --installed | grep $package
					elif [ $check == 5]
						exit
					else
						break
					fi
				done
			elif [ $part == 2 ]
			then
				while true
				do
				echo "
		${green}What do you want to check?
		${blue}1${reset} check which users have a sudo rights
		${blue}2${reset} check that DHCP is deactivated
		${blue}3${reset} check netmask and IP
		${blue}4${reset} check that the port of SSH modified, root user is not able to connect via SSH and SSH access done with publickeys
		${blue}5${reset} list firewall rules
		${blue}6${reset} test a DOS and check that fail2ban is installed
		${blue}7${reset} check open ports
		${blue}8${reset} check active services of the machine
		${blue}9${reset} check that there is a script to update all packages
		${blue}10${reset} check that there is a script to monitor changes
		${blue}11${reset} check that there is SSL on all services
		${blue}12${reset} exit totally"
				read check
				if [ $check == 1 ]
				then
					tput setaf 3; sudo cat /etc/sudoers
				elif [ $check == 2 ]
				then
					tput setaf 3; sudo cat /etc/network/interfaces
				elif [ $check == 3 ]
				then
					tput setaf 3; sudo cat /etc/network/interfaces.d/*
				elif [ $check == 4 ]
				then
					tput setaf 3; sudo cat /etc/ssh/sshd_config | grep Port && sudo cat /etc/ssh/sshd_config | grep Root && sudo cat /etc/ssh/sshd_config  | grep  Pubkey
				elif [ $check == 5 ]
				then
					tput setaf 3; sudo ufw status
				elif [ $check == 6 ]
				then
					tput setaf 3; sudo apt list --installed | grep fail2ban
				elif [ $check == 7 ]
				then
					tput setaf 3; nmap localhost
				elif [ $check == 8 ]
				then
					tput setaf 3; sudo systemctl list-unit-files --type=service | grep enabled
				elif [ $check == 9 ]
				then		
					tput setaf 3; sudo cat /var/log/update_script.log
					tput setaf 3; sudo crontab -l
				elif [ $check == 10 ]
				then
					tput setaf 3; sudo crontab -l
				elif [ $check == 11 ]
				then
					tput setaf 3
					# echo "Add space to the end of the file /etc/crontab"
					# sudo vim /etc/crontab
					# verify_syntax /etc/crontab
					cronmonitor=sudo crontab -l | grep "0 0 * * " | cut -d " " -f7
					echo $cronmonitor
					bash /home/diana/cronmonitor.sh
					echo "Checking mail"
					sudo mail
				elif [ $check == 12 ]
					exit
				else
					break
				fi
				done
			elif [ $part == 3 ]
			then
				read -p "${green} type username ${reset}" name
				read -p "${green} remotehost: ${reset}" remotehost
				read -p "${green} port: ${reset}" remoteport
				ssh $name@$remotehost -p $remoteport
			elif [] $part == 4 ]
				exit
			else
				break
			fi
		done
	else
		break
	fi
done

