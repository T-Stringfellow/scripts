#/bin/bash

### CHECK PERMISSIONS LOCKED ON PASSWD & SHADOW, THEN RUN SUDO LISTING

#DEFINING LIST VARIABLE
files=(
   /etc/passwd
   /etc/shadow
)

        #FORMATTING
echo -e "--LISTING FILE PERMISSIONS--\n"
#PERMISSIONS CHECK
for file in ${files[@]}
do
ls -l $file
done

        ##FORMATTING
echo -e "\n--SUDO PRIVILLEGE LIST--\n"
#SUDO PRIVILLEGE ASSESMENT
for user in $(ls /home)
do 
sudo -lU $user
done



