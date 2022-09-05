#!/bin/bash

# Functions sends message to syslog and to standard output if VERBOSE is true.

log() {
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t log.sh "${MESSAGE}"
}

backup_file() {
	# This function creates a backup of a file. Returns non-zero status on error.

	local FILE="${1}"

	# Make sure file exist.
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="var/tmp/$(basename ${FILE}).$(date +%F-%N)"
		log "Backing up ${FILE} to ${BACKUP_FILE}."

	# The exit status of the function will be the exit status of the cp command.
		cp -p ${FILE} ${BACKUP_FILE}
	else
	# The file does not exist, so return a non-zero exit status.
		return 1
	fi
}
readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'

backup_file 'etc/passwd'

