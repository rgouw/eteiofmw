#!/bin/bash
export SOA_DOMAIN_HOME=/u01/app/work/domains/soa_domain
echo
echo Recreate domain: $SOA_DOMAIN_HOME
rm -rf $SOA_DOMAIN_HOME
wlst.sh createSoaDomainClustered.py
