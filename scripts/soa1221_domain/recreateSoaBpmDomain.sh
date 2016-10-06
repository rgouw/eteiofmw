#!/bin/bash
. fmw12c_env.sh
export SOA_DOMAIN_HOME=/data/oracle/config/domains/book_domain
echo
echo Recreate domain: $SOA_DOMAIN_HOME
rm -rf $SOA_DOMAIN_HOME
wlst.sh createSoaBpmDomain.py -loadProperties darlin-vce-book.properties
