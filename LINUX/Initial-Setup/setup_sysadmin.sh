#!/bin/bash

# Quick setup script for new server.

# Make sure the script is run as root.
if [ $UID -ne 0 ]
then
echo "Please run this script with sudo."
  exit
fi

# Create a log file that our script will use to track its progress
log_file=/var/log/setup_script.log

# Log file header
echo "Log file for general server setup script." >> $log_file
echo "############################" >> $log_file
echo "Log generated on: $(date)" >> $log_file
echo "############################" >> $log_file
echo "" >> $log_file

# List of necessary packages
packages=(
  'nano'
  'wget'
  'net-tools'
  'python'
  'tripwire'
  'tree'
  'lynis'
  'curl'
  'lynx'
  'fortune'
  'cowsay'
  'unzip'
  'hashcat'
  'aircrack-ng'
  'steghide'
)

# Ensure all packages are installed
for package in ${packages[@]}
do
  if [ ! $(which $package) ]
  then
    apt install -y $package
  fi
done


echo "$(date) Installed needed packages: ${packages[@]}" | tee -a $logfile


##### BEGIN USERNAME ADD ####

# Create the user sysadmin with no password (password to be created upon login)
#!/bin/bash

CREATE_ACCOUNT=sysadmin

if id "$CREATE_ACCOUNT" >/dev/null 2>&1; then
        echo "user exists"
else
        useradd sysadmin
        chage -d 0 sysadmin
fi


# Add the sysadmin user to the `sudo` group

usermod -aG sudo sysadmin

# Print and log
echo "$(date) Created sys_admin user. Password to be created upon login" | tee -a $log_file

# Remove roots login shell and lock the root account.
usermod -s /sbin/nologin root
usermod -L root

# Print and log
echo "$(date) Disabled root shell. Root user cannot login." | tee -a $log_file

# Change permissions on sensitive files
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/group
chmod 644 /etc/passwd

# Print and log
echo "$(date) Changed permissions on sensitive /etc files." | tee -a $log_file


# Setup scripts folder
if [ ! -d /home/sysadmin/scripts ]
then
mkdir /home/sysadmin/scripts
chown sysadmin:sysadmin /home/sysadmin/scripts
fi

# Add scripts folder to .bashrc for $USER
echo "" >> /home/sysadmin/.bashrc
echo "PATH=$PATH:/home/sysadmin/scripts" >> /home/sysadmin/.bashrc
echo "" >> /home/sysadmin/.bashrc

# Print and log
echo "$(date) Added ~/scripts directory to sysadmin's PATH." | tee -a $log_file

#bash
# Add custom aliases to /home/sysadmin/.bashrc
echo "#Custom Aliases" >> /home/sysadmin/.bashrc
echo "alias rr='source ~/.bashrc && echo Bash config reloaded'" >> /home/sysadmin/.bashrc
echo "alias rm='rm -i'" >> /home/sysadmin/.bashrc
echo "alias docs='cd ~/Documents'" >> /home/sysadmin/.bashrc
echo "alias down='cd ~/Downloads'" >> /home/sysadmin/.bashrc
echo "alias etc='cd /etc'" >> /home/sysadmin/.bashrc
echo "alias c='clear && pwd && l'" >> /home/sysadmin/.bashrc
echo "alias edit='nano ~/.bashrc'" >> /home/sysadmin/.bashrc
echo "alias lol='fortune | cowsay'" >> /home/sysadmin/.bashrc
echo "alias lr='ls -R'" >> /home/sysadmin/.bashrc
echo "alias lsa='ls -a'" >> /home/sysadmin/.bashrc
echo "alias cal='cal -A 1'" >> /home/sysadmin/.bashrc
echo "alias future='date && cal -A 1'" >> /home/sysadmin/.bashrc
echo "alias desk='cd ~/Desktop'" >> /home/sysadmin/.bashrc

# Print and log
echo "$(date) Added custom alias collection to sysadmin's bashrc." | tee -a $log_file

# Wireshark Set-up
sudo apt install wireshark -y
sudo adduser --system --no-create-home wireshark
echo "Wireshark Installed!"
echo "Wireshark Installed!" >> $log_file


#Print out and log Exit
echo "$(date) Script Finished. Exiting."
echo "$(date) Script Finished. Exiting." >> $log_file

exit

