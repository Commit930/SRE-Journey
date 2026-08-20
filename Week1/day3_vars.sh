#!/bin/bash

NAME="DEVOPS"
echo "${NAME^^}"
echo "${#NAME}"

if [ -f "/var/log/syslog" ]; then
echo "Log file exists"
LINES=$(wc -l < /var/log/syslog)
echo "LINES:$LINES"
else
echo "Log file not found"
fi