#!/bin/bash
#############################################################################
# Stop AdminServer using wlst 
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Stop AdminServer
wlst.sh stopAdmin.py -loadProperties fmw.properties