#!/bin/bash
#############################################################################
# Start OSB Cluster using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Start Osb Cluster
wlst.sh startOsbCluster.py -loadProperties fmw.properties
