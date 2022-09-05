#!/bin/bash

# This script pings a list of servers and reports their stsatus.

SERVER_FILE='/vagrant/servers'

if [[ ! -e "${SERVER_FILE}" ]]
then
  echo "Cannot open ${SERVER_FILE}." >&2
  exit 1
fi

for SERVER in $(cat ${SERVER_FILE})
do
  echo "Pinging ${SERVERS}"
  ping -c 2 ${SERVER} &> /dev/null
  if [[ "${?}" -ne 0 ]]
  then
    echo "${SERVER} down."
  else
    echo "${SERVER} up."
  fi
done

