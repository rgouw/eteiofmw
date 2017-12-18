#!/bin/bash
export ORACLE_BASE=/app/oracle
export JAVA_HOME=$ORACLE_BASE/product/jdk
export MW_HOME=$ORACLE_BASE/product/jdeveloper/12213_BPMQS
. $MW_HOME/wlserver/server/bin/setWLSEnv.sh
export PATH=$PATH:$MW_HOME/oracle_common/common/bin
wlst.sh createDemoUsers.py -loadProperties createDemoUsers.properties
