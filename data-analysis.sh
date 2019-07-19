#!/bin/bash

# Setting these environment variables can speed up some scripts
LC_ALL=C
LANG=C

trap 'rm temporary files that were generated' EXIT SIGINT SIGKILL

do-things
