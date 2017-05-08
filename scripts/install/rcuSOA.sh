#!/bin/bash
. $PWD/fmw12c_env.sh
. $PWD/db12c_env.sh
#
echo Run rcu for SOA Infrastucture
export RCU_INSTALL_HOME=$PWD/../Extracted/stage
export RCU_SOA_RSP=rcuSOA.rsp
export RCU_SOA_RSP_TPL=$RCU_SOA_RSP.tpl
export RCU_SOA_PWD=rcuSOAPasswords.txt
#
export DB_SCHEMA_PREFIX=DEV
# DB_PROFILE: SMALL/MED/LARGE
export DB_PROFILE=SMALL
#
echo Substitute $RCU_SOA_RSP_TPL to $RCU_SOA_RSP
envsubst < $RCU_SOA_RSP_TPL > $RCU_SOA_RSP
#export RCU_SOA_PWD=rcuSOAPasswords-same.txt
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $RCU_SOA_RSP -f < $RCU_SOA_PWD
