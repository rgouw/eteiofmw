#!/bin/bash
. fmw12c_env.sh
echo
echo Enroll domain
wlst.sh enrollDomain.py -loadProperties fmw.properties