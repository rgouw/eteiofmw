#!/bin/bash
. fmw12c_env.sh
export SOA_DOMAIN_HOME=/u01/app/work/domains/soabpm_domain
echo
echo Recreate domain: $SOA_DOMAIN_HOME
rm -rf $SOA_DOMAIN_HOME
wlst.sh createSoaBpmDomain.py -loadProperties darlin-vce-db-soabpm.properties
