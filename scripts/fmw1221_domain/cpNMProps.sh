#!/bin/bash
export NM_HOME=/u01/app/work/domains/soabpm_domain/nodemanager
export INST_HOME=/media/sf_Stage/install/software/FMW/scripts/soa1221_domain
echo Copy plain-listener nodemanager.properties van $INST_HOME naar $NM_HOME
cp $INST_HOME/nodemanager.properties $NM_HOME
