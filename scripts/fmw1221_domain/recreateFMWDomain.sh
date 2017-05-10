#!/bin/bash
. fmw12c_env.sh
export FMW_DOMAIN_HOME=/data/oracle/config/domains/fmw_domain
echo
echo Recreate domain: $FMW_DOMAIN_HOME
rm -rf $FMW_DOMAIN_HOME
wlst.sh createSoaBpmDomain.py -loadProperties fmw.properties
