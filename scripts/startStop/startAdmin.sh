#!/bin/bash
#############################################################################
# Start AdminServer using wlst and connect to it.
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Start AdminServer
wlst.sh ./startAdmin.py -loadProperties fmw.properties