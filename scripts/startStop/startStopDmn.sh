#!/bin/bash
#############################################################################
# (Re-)start or stop Domain components using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2017-04-19
#
#############################################################################
#
. fmw12c_env.sh
export START_STOP_OPTION=$1
export COMPONENT_TYPE=$2
export ENV=$3
export COMPONENT_NAME=$4
echo
echo "(Re-)Start or stop Domain components"
wlst.sh ./startStopDomain.py ${START_STOP_OPTION} ${COMPONENT_TYPE} "${COMPONENT_NAME}" -loadProperties ${ENV}.properties
