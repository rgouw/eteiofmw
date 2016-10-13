#!/bin/bash
#############################################################################
# Start SOA Cluster using wlst
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#  
. fmw12c_env.sh
echo
echo Start Soa Cluster
wlst.sh startSoaCluster.py -loadProperties fmw.properties
