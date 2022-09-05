#!/bin/bash

# Creating new accounts 
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.


# Make sure user is being executed with superuser
if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo or as root.' >&2
	exit 1
fi

# If they don't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
    echo "Create an account on the local system with the anme of USER_NAME and a comments filed of COMMENT." >&2
    exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"

# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c16)

# Creating the new user with the password
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# Check if the account is created
if [[ ${?} -ne 0 ]]
then
	echo 'The account could not be created.' >&2
	exit 1
fi

# Set Password
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# Check if password is okay
if [[ ${?} -ne 0 ]]
then
	echo 'The password for the account could not be set.' >&2
	exit 1
fi

# Force change on first login
passwd -e ${USER_NAME} &> /dev/null 

# Return the username, password, and host of the account
echo 'username: '
echo "${USER_NAME}"
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo 'Account Details'
echo "${COMMENT}"
echo
echo 'host: '
echo "${HOSTNAME}"
exit 0


