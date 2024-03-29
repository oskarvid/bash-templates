#!/bin/bash

# Use this for troubleshooting
#set -vo xtrace

# Use this to run code when the script exits with specific exit codes
trap function exit-codes

# Write all terminal output to logfile
exec &> >(tee logfile.log)

# put "trap die ERR" in the main script to use this in a trap that executes when there is an error in the script
die () {
	echo "Execution failed on line $BASH_LINENO"
}

# Use this is error messages and such
usage () {
	printf "Usage: $0 #ADD INSTRUCTIONS HERE"
	exit
}

# Make printed text beautiful with colors <3
# Syntax: echo "${RED}""Write text here"
# Syntax: printf "${RED}""Write text here\n"
# Syntax: echo "${RED}""Red text here ""${GREEN}""And green text here"
# Print yellow text
BLACK=$(tput setaf 0)
# Print red text
RED=$(tput setaf 1)
# Print green text
GREEN=$(tput setaf 2)
# Print yellow text
YELLOW=$(tput setaf 3)
# Print blue text
BLUE=$(tput setaf 4)
# Print magenta text
MAGENTA=$(tput setaf 5)
# Print cyan text
CYAN=$(tput setaf 6)
# Print white text
WHITE=$(tput setaf 7)
# Reset back to standard terminal color
RESET=$(tput sgr 0)

# Shows date in the format "YYYY-MM-DD hh:mm:ss"
showdate () {
	local DATE
	DATE=$(date "+%F %T")
	printf "$DATE"
}

# Print error message with timestamp
err () {
	local DATE
	DATE=$(showdate)
	printf "[$DATE][${RED}ERROR${RESET}]: $1\n" 1>&2
}

# Print warning message with timestamp
warn () {
	local DATE
	DATE=$(showdate)
	printf "[$DATE][${YELLOW}WARNING${RESET}]: $1\n"
}

# Print information message with timestamp
inf () {
	local DATE
	DATE=$(showdate)
	printf "[$DATE][INFO]: $1\n"
}

# Print success message with timestamp
succ () {
	local DATE
	DATE=$(showdate)
	printf "[$DATE][${GREEN}SUCCESS${RESET}]: $1\n"
}

# Simplified rsync, it accepts arguments
rprog () {
	rsync -h -avz --delete --progress $@
}

# Print nice asci art
print-ascii () {
inf "Here is a fun text"
cat << "EOF"
,'";-------------------;"`.
;[]; ................. ;[];
;  ; ................. ;  ;
;  ; ................. ;  ;
;  ; ................. ;  ;
;  ; ................. ;  ;
;  ; ................. ;  ;
;  ; ................. ;  ;
;  `.                 ,'  ;
;    """""""""""""""""    ;
;    ,-------------.---.  ;
;    ;  ;"";       ;   ;  ;
;    ;  ;  ;       ;   ;  ;
;    ;  ;  ;       ;   ;  ;
;//||;  ;  ;       ;   ;||;
;\\||;  ;__;       ;   ;\/;
 `. _;          _  ;  _;  ;
   " """"""""""" """"" """
EOF
}
