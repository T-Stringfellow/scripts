
#!/bin/bash

## SIMPLE CLEAN UP SCRIPT -- CRONable FOR REGULAR MAINTENANCE

## Make sure the script is run as root. LEAVE COMMENTED FOR CRONjob
#if [ $UID -ne 0 ]
#then
#echo "Please run this script with sudo."
#  exit
#fi

# Clean up temp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

# Clear apt cache
apt clean -y

# Clear thumbnail cache for sysadmin, instructor, and student
rm -rf /home/sysadmin/.cache/thumbnails


