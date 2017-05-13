#!/bin/bash
#############################################################################
# Create user config files using wlst.sh
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Create User Config files
wlst.sh ./createUserConfigFiles.py -loadProperties fmw.properties