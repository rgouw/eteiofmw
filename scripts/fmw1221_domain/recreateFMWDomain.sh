#!/bin/bash
. fmw12c_env.sh
echo
echo Recreate domain: $DOMAIN_HOME
rm -rf $DOMAIN_HOME
wlst.sh createFMwDomain.py -loadProperties fmw.properties
