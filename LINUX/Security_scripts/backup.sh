#!/bin/bash

#  UNCOMMENT FOR DATE NAMING PROMPT
var=$(date +%m%d%y)
sudo tar cvvfW /var/backup/home.tar /home

sudo mv  /var/backup/home.tar /var/backup/home.$var.tar

ls -lh /var/backup > /var/backup/file_report.txt

free -h > /var/backup/disk_report.txt

