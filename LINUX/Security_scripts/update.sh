#!/bin/bash

# ENSURE APT IS UPDATE -- CAN BE CRONJOB'D FOR FUTURE AUTOMATION

## Make sure the script is run as root. LEAVE COMMENTED FOR CRONjob
#if [ $UID -ne 0 ]
#then
#echo "Please run this script with sudo."
#  exit
#fi

# Ensure apt has all available updates
apt update -y

# Upgrade all installed packages
apt upgrade -y

# Install new packages, and uninstall any old packages that
# must be removed to install them
apt full-upgrade -y

# Remove unused packages and their associated configuration files
apt autoremove --purge -y


