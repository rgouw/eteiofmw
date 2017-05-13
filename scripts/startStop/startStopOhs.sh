#!/bin/bash
#############################################################################
# (Re-)Start or stop OHS components using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2017-04-20
#
#############################################################################
#
. fmw12c_env.sh
export START_STOP_OPTION=$1
export ENV=$2
echo
echo "(Re-)Start or stop Domain components"
wlst.sh ./startStopOhs.py ${START_STOP_OPTION} -loadProperties ${ENV}.properties