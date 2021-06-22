#!/bin/bash

### GENERATE SYSTEM REPORT IN USER HOME DIRECTORY
	##sudo needed to check for exe files

## Make sure the script is run as root. LEAVE COMMENTED FOR CRONjob
#if [ $UID -ne 0 ]
#then
#echo "Please run this script with sudo."
#  exit
#fi

#DEFINE VARIABLES

IPSEEK=$(ip addr | grep inet | tail -3 | head -1 | awk '{print $2}')
EXESEARCH=$(find /home -type f -perm 777)

#DEFINING LIST VARIABLE
files=(
    /etc/passwd
    /etc/shadow
)


#CREATES RESEARCH FOLDER
	#RETURNTS NO ERROR WITH 2>/dev/null MODIFIER
if [ ! -d /home/sysadmin/research ]
   then
      mkdir /home/sysadmin/research 2>/dev/null
fi

# DELETES EXISITNG SYSTEM REPORT

if [ -f /home/sysadmin/research/sys_info.txt ]
   then
    > /home/sysadmin/research/sys_info.txt
fi

# BEGIN SYSTEM REPORT GENERATION // OUTPUTS TO RESEARCH DIRECTORY
   echo "--SYSTEM INFO $(date)--" >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--MACHINE INFO--\n$(uname) ($MACHTYPE)" >> /home/sysadmin/research/sys_info.txt
   echo --DETAILED VERSION INFO-- >> /home/sysadmin/research/sys_info.txt
   echo $(uname -a) >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--HOST INFO--" >> /home/sysadmin/research/sys_info.txt
   echo "The hostname is $HOSTNAME" >> /home/sysadmin/research/sys_info.txt
   echo "HOST IP: $IPSEEK" >> /home/sysadmin/research/sys_info.txt
   echo "-----------------------" >> /home/sysadmin/research/sys_info.txt
   echo "DNS SERVERS: " >> /home/sysadmin/research/sys_info.txt
   cat /etc/resolv.conf | tail -2 >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--MEMORY USAGE--\n$(free -h)" >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--CPU INFO--" >> /home/sysadmin/research/sys_info.txt
      lscpu | grep CPU >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--DISK USAGE--" >> /home/sysadmin/research/sys_info.txt
      df -H | head -2 >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--CURRENTLY LOGGED IN USERS--\n$(users)" >> /home/sysadmin/research/sys_info.txt
   echo -e "\n--LISTING FILE PERMISSIONS--\n" >> /home/sysadmin/research/sys_info.txt
#PERMISSIONS CHECK
for file in ${files[@]}
do
ls -l $file >> /home/sysadmin/research/sys_info.txt
done


echo -e "\n--Exec Files--\n$EXESEARCH" >> /home/sysadmin/research/sys_info.txt
                #777 indicates search for eXecutable files 777 triggers -ANY- match
#UNCOMMENT TO SEARCH FOR ALL EXE FILES WITHOUT R/W ACCESS FOR "OTHER"
find /home -type f -perm 775 >> /home/sysadmin/research/sys_info.txt

echo -e "\n --TOP 10 ACTIVE PROCESSESS--" >> /home/sysadmin/research/sys_info.txt
   ps aux --sort -%mem | awk '{print $1, $2, $3, $4, $11}' | head >> /home/sysadmin/research/sys_info.txt


