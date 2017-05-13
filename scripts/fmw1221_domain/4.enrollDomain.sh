#!/bin/bash
. fmw12c_env.sh
echo
echo Enroll domain $DOMAIN_HOME
wlst.sh enrollDomain.py -loadProperties fmw.properties
