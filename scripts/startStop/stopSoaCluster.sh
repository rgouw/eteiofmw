#!/bin/bash
#############################################################################
# Start Soa Cluster using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Stop Soa Cluster
wlst.sh stopSoaCluster.py -loadProperties fmw.properties
