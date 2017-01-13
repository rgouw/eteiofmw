#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export FMW_HOME=/u01/app/oracle/FMW12210
export NODEMGR_HOME=/u01/app/work/domains/soabpm_domain/nodemanager

export SOA_HOME=$FMW_HOME/soa
export OSB_HOME=$FMW_HOME/osb
export MFT_HOME=$FMW_HOME/mft
#
echo call setWLSEnv.sh
. $FMW_HOME/wlserver/server/bin/setWLSEnv.sh
export PATH=$FMW_HOME/oracle_common/common/bin:$WL_HOME/common/bin/:$WL_HOME/server/bin:$PATH
