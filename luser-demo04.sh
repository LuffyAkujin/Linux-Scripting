#!/bin/bash

# This script creates an account on the local system
# You will be prompted for the account name and passowrd.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password
read -p 'Enter the passowrd to use for the accouint: ' PASSWORD

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}

