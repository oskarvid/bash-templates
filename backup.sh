#!/bin/bash

set -Ee
# Uncomment to enable debugging
#set -vo xtrace

DATE=$(date +%F)

# Set this to the directory that stores your backups
# username@ip-or-hostname:/destination/ also works
DESTINATION=/path/to/your/backup/directory/

source functions.sh

if [[ $# -lt 1 ]]; then
	inf "Must use one argument"
	usage
elif [[ $# -ge 3 ]]; then
	inf "Max one flag and argument allowed"
	usage
elif [[ $1 == "-c" && $# -gt 2 || $1 == "-d" && $# -gt 2 ]]; then
 	inf "Only one argument for $1 allowed"
	usage
fi

while getopts 'c:d:bh' flag; do
	case "${flag}" in
	c)
		c=${OPTARG}
		MODE="compress"
		;;
	b)
		b=${OPTARG}
		MODE="backup"
		;;
	d)
		d=${OPTARG}
		MODE="both"
		;;
	h)
		usage
		;;
	?)
		usage
		;;
	esac
done

if [[ $MODE == compress ]]; then
	tar -zcvf "$(basename ${2})"-"${DATE}".tar.gz ${2} && \
	succ "$(basename ${2})-${DATE}.tar.gz has been created"
elif [[ $MODE == backup ]]; then
	rprog *.tar.gz $DESTINATION && \
	succ "All .tar.gz archives have been backed up to the backup server"
elif [[ $MODE == both ]]; then
	tar -zcvf "$(basename ${2})"-"${DATE}".tar.gz ${2} && \
	inf "Preparing to upload all .tar.gz archives to backup server" && \
	sleep 3 && \
	rprog *.tar.gz $DESTINATION && \
	succ "$(basename ${2})-${DATE}.tar.gz archive successfully created and all .tar.gz archives have been backed up on the remote backup server"
fi
