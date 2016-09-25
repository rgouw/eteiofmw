#!/bin/bash
. $PWD/FMW12c_env.sh
echo Run rcu for SOA Infrastucture
export RCU_INSTALL_HOME=$PWD/../rcu
export RCU_SOA_RSP=rcuSOA.rsp
export RCU_SOA_PWD=rcuSOAPasswords.txt
#export RCU_SOA_PWD=rcuSOAPasswords-same.txt
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $RCU_INSTALL_HOME/$RCU_SOA_RSP -f < $RCU_INSTALL_HOME/$RCU_SOA_PWD