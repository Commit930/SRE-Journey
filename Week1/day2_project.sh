#!/bin/bash

if pgrep -x "sshd" > /dev/null; then
echo "process is running"
else
echo "$(date) process is not running" >> /var/log/process_check.log  
fi

## > is write it to a log file and not the screen
# >> is used for append (so it helps build overtime than over write)
# when calling a variable "$<variable>", when appending something "{<variable>}_fedg", upper case "{$<variable>^^}", 
#for length "${#<variable>}"
