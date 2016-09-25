#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
#export JAVA_HOME=/usr/java/jdk1.8.0_74
export FMW_HOME=/u01/app/oracle/FMW12210
#export WL_HOME=${FMW_HOME}/wlserver
#export NODEMGR_HOME=/u01/app/work/domains/soabpm12c_dev/nodemanager
export NODEMGR_HOME=/u01/app/work/domains/osb_domain/nodemanager

export SOA_HOME=$FMW_HOME/soa
export OSB_HOME=$FMW_HOME/osb
export MFT_HOME=$FMW_HOME/mft
#
echo call setWLSEnv.sh
. $FMW_HOME/wlserver/server/bin/setWLSEnv.sh
export PATH=$FMW_HOME/oracle_common/common/bin:$WL_HOME/common/bin/:$WL_HOME/server/bin:$PATH
