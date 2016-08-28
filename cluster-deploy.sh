#!/bin/sh

user=azureuser

# Looping through a file: 
# http://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash
while read server
do 
    scp -P 2223 ssr-init.sh $user@$server:~/; 
    # -t ensures remote sudo will work: 
    # http://stackoverflow.com/questions/10310299/proper-way-to-sudo-over-ssh
    ssh -t -p 2223 $user@$server "chmod +x ssr-init.sh && ./ssr-init.sh"; 
done < servers.txt
