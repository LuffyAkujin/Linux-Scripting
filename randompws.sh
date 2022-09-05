#!/bin/bash

# This script generates a list of random passwords.

# A random number as a password.
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# 3 Random numbers together

PASSWORD="${RANDOM}${RANDOM}${RAMDOM}"
echo "${PASSWORD}"

# Use date/time for password

PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Include nanosec

PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# Better PWS

PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# Even Better PWS

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c32)
echo "${PASSWORD}"

# The Super PWS
SPECIAL_CHARACTER=$(echo '!@$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"