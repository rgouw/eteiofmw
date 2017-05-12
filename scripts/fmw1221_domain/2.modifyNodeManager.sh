#!/bin/bash
. fmw12c_env.sh
echo
echo Modify Nodemanager: $NODEMGR_HOME
wlst.sh modifyNodeManager.py -loadProperties fmw.properties
