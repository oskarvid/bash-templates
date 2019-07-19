#!/bin/bash

source functions.sh

if [[ $# -lt 1 ]]; then
	inf "Must use one argument"
	usage
fi

while getopts 'c:h' flag; do
	case "${flag}" in
	c)
		c=${OPTARG}
		;;
	h)
		usage
		;;
	?)
		usage
		;;
	esac
done

do-things