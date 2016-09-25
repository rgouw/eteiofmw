#!/bin/bash
#############################################################################
# Start OSB Domain using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Stop Osb Domain
wlst.sh stopOsbDomain.py -loadProperties fmw.properties
