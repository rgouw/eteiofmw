#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export JAVA_HOME=/usr/java/jdk1.8.0_101
export ORACLE_BASE=/app/oracle
export FMW_HOME=$ORACLE_BASE/product/middleware/FMW12211
export WL_HOME=${FMW_HOME}/wlserver
export SHARED_CONFIG_DIR=/data/oracle/config
export DOMAIN_NAME=book_domain
export DOMAIN_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export NODEMGR_HOME=$DOMAIN_HOME/nodemanager
#
export SOA_HOME=$FMW_HOME/soa
export OSB_HOME=$FMW_HOME/osb
export MFT_HOME=$FMW_HOME/mft
#
echo call setWLSEnv.sh
. $FMW_HOME/wlserver/server/bin/setWLSEnv.sh
export PATH=$FMW_HOME/oracle_common/common/bin:$WL_HOME/common/bin/:$WL_HOME/server/bin:$PATH