#!/bin/bash

mag=`tput setaf 5`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

while true
do
	read -p "
${green}Which part do you want to check?
${blue}1${reset} VM part
${blue}2${reset} Network and Security Part
${blue}3${reset} Web Part
${blue}4${reset} Exit
${green}your answer: ${reset}" part
	if [ $part == 1 ]
	then
		while true
		do
		read -p "
	${green}What do you want to do?
	${blue}1${reset} check disk size
	${blue}2${reset} check partition
	${blue}3${reset} check if packages are uptodate
	${blue}4${reset} check if packages contain
	${blue}5${reset} exit
	${green}your answer: ${reset}" check
			if [ $check == 1 ]
			then
				echo "${mag}sudo fdisk -l${reset}"
				tput setaf 3; sudo fdisk -l
			elif [ $check == 2 ]
			then
				echo "${mag}sudo df -h --total${reset}"
				tput setaf 3; sudo df -h --total
			elif [ $check == 3 ]
			then
				echo "${mag}sudo apt list --upgradable${reset}"
				tput setaf 3; sudo apt list --upgradable
			elif [ $check == 4 ]
			then
				read -p "${green} type name of package you want to check ${reset}" package
				echo "${mag}sudo apt list --installed | grep $package${reset}"
				tput setaf 3; sudo apt list --installed | grep $package
			elif [ $check == 5 ]
			then
				break
			else
				exit
			fi
		done
	elif [ $part == 2 ]
	then
		while true
		do
		read -p "
	${green}What do you want to check?
	${blue}1 ${reset} check which users have a sudo rights
	${blue}2 ${reset} check that DHCP is deactivated
	${blue}3 ${reset} check netmask and IP
	${blue}4 ${reset} check that the port of SSH modified, root user is not able to connect via SSH and SSH access done with publickeys
	${blue}5 ${reset} list firewall rules
	${blue}6 ${reset} test a DOS and check that fail2ban is installed
	${blue}7 ${reset} check open ports
	${blue}8 ${reset} check active services of the machine
	${blue}9 ${reset} check cron jobs, that there are at least 3 jobs
	${blue}10${reset} check script to update packages
	${blue}11${reset} check script to monitor changes of the file /etc/crontab 
	${blue}12${reset} check that there is SSL on all services
	${blue}13${reset} exit
	${green}your answer: ${reset}" check

		case $check in
			1)
				echo "${mag}sudo cat /etc/sudoers ${reset}"
				tput setaf 3; sudo cat /etc/sudoers
			;;
			2)
				echo "${mag}sudo cat /etc/network/interfaces${reset}"
				tput setaf 3; sudo cat /etc/network/interfaces
				;;
			3)
				echo "${mag}sudo cat /etc/network/interfaces.d/*${reset}"
				tput setaf 3; sudo cat /etc/network/interfaces.d/*
				;;
			4)
				echo "${mag}sudo cat /etc/ssh/sshd_config | grep \"Port\|Root\|Pubkey\"${reset}"
				tput setaf 3; sudo cat /etc/ssh/sshd_config | grep "Port\|Root\|Pubkey"
				;;
			5)
				echo "${mag}sudo ufw status${reset}"
				tput setaf 3; sudo ufw status
				;;
			6)
				echo "${mag}sudo apt list --installed | grep fail2ban${reset}"
				tput setaf 3; sudo apt list --installed | grep fail2ban
				echo "${mag}sudo apt-get install git${reset}"
				sudo apt-get install git
				echo "${mag}git clone https://github.com/gkbrk/slowloris.git${reset}"
				git clone https://github.com/gkbrk/slowloris.git
				read -p "enter IP want to attack " ip
				echo "${mag}perl slowloris/slowloris.py $ip${reset}"
				perl slowloris/slowloris.py $ip
				echo "${mag}sudo cat /var/log/fail2ban.log$ip${reset}"
				sudo cat /var/log/fail2ban.log
				;;
			7)
				echo "${mag}nmap localhost${reset}"
				tput setaf 3; nmap localhost
				;;
			8)
				echo "${mag}sudo systemctl list-unit-files --type=service | grep enabled$ip${reset}"
				tput setaf 3; sudo systemctl list-unit-files --type=service | grep enabled
				;;
			9)
				echo "${mag}sudo crontab -l$ip${reset}"
				tput setaf 3; sudo crontab -l
				;;
			10)
				echo "${mag}sudo cat /var/log/update_script.log${reset}"
				tput setaf 3; sudo cat /var/log/update_script.log
				read -p "${green}do you want to add something to the end of the file /var/log/update_script.log (y/n)
				your answer: ${reset}" answer
				if [ $answer == y ]
				then
					echo "${mag}sudo vim /var/log/update_script.log${reset}"
					tput setaf 3; sudo vim /var/log/update_script.log
				fi
				echo "${mag}sudo crontab -l | grep reboot${reset}"
				tput setaf 3; sudo crontab -l | grep reboot
				if [ $answer == y ]
				then
					read -p "${green}type this script here to run it: ${reset}" script
					echo "${mag}bash $script ${reset}"
					tput setaf 3; bash $script
					echo "${mag}sudo cat /var/log/update_script.log${reset}"
					tput setaf 3; sudo cat /var/log/update_script.log
				fi
				;;
			11)
				echo "${mag}sudo mail $script ${reset}"
				sleep 2
				tput setaf 3; sudo mail
				echo "${green}Add something to the end of the file /etc/crontab${reset}"
				read -p "${mag}sudo vim /etc/crontab (press smth to continue)${reset}" enter
				sudo vim /etc/crontab
				echo "${mag}sudo crontab -l | grep \"0 0 * * *\"${reset}"
				tput setaf 3; sudo crontab -l | grep "0 0 * * *"
				read -p "${green}type this script here to run it: ${reset}" script
				echo "${mag}bash $script ${reset}"
				tput setaf 3; bash $script
				echo "${mag}sudo mail $script ${reset}"
				sleep 3
				tput setaf 3; sudo mail
				;;
			12)
				echo "${mag}sudo cat /etc/apache2/sites-available/default-ssl.conf | grep \"ServerAdmin \|ServerName\|SSLCertif\"${reset}"
				tput setaf 3; sudo cat /etc/apache2/sites-available/default-ssl.conf | grep "ServerAdmin \|ServerName\|SSLCertif"
				echo "${mag}sudo cat /etc/apache2/conf-available/ssl-params.conf${reset}"
				tput setaf 3; sudo cat /etc/apache2/conf-available/ssl-params.conf
				echo "${mag}sudo cat /etc/apache2/sites-available/000-default.conf${reset}"
				tput setaf 3; sudo cat /etc/apache2/sites-available/000-default.conf
				echo "${mag}sudo systemctl status apache2${reset}"
				tput setaf 3; sudo systemctl status apache2
				;;
			*)
				break
				;;
		esac
		read -p "${green}press enter to continue or 0 to finnish this test ${reset}" next
		if [ "$next" == "0" ]
		then
			break
		else
			continue
		fi
		done
	elif [ $part == 3 ]
	then
		while true
		do
			read -p "
	${green}What do you want to do?
	${blue}1${reset} check that the package of a Web server is installed
	${blue}2${reset} check that there are only one active configuration
	${blue}3${reset} exit
	${green}your answer: ${reset}" check
			if [ $check == 1 ]
			then
				echo "${mag}sudo apt list --installed | grep \"nginx|apache\"${reset}"
				tput setaf 3; sudo apt list --installed | grep "nginx\|apache"
			elif [ $check == 2 ]
			then
				echo "${mag}sudo cat /etc/apache2/sites-available/000-default.conf${reset}"
				tput setaf 3; sudo cat /etc/apache2/sites-available/000-default.conf
			elif [ $check == 3 ]
			then
				break
			else
				exit
			fi
		done
	else
		break
	fi
done
