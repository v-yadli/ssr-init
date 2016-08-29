#!/bin/sh

user=azureuser
port=1234

# Looping through a file: 
# http://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash
while read server
do 
    scp -P $port ssr-init.sh $user@$server:~/; 
    # -t ensures remote sudo will work: 
    # http://stackoverflow.com/questions/10310299/proper-way-to-sudo-over-ssh
    ssh -t -p $port $user@$server "chmod +x ssr-init.sh && ./ssr-init.sh"; 
done < servers.txt
