#!/bin/bash

# Creating new accounts 

# Make sure user is being executed with superuser
if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo or as root.'
	exit 1
fi

# Ask for username
read -p 'Enter username: ' USER_NAME

# Ask for name
read -p 'Enter name: ' COMMENT

# Ask for password
read -p 'Enter password: ' PASSWORD

# Creating the new user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check if the account is created
if [[ ${?} -ne 0 ]]
then
	echo 'OK'
	exit 1
fi

# Set Password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check if password is okay
if [[ ${?} -ne 0 ]]
then
	echo 'OK'
	exit 1
fi

# Force change on first login
passwd -e ${USER_NAME}

# Return the username, password, and host of the account
echo
echo 'username: '
echo "${USER_NAME}"
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo 'host: '
echo "${HOSTNAME}"
exit 0


