#!/bin/bash
. fmw12c_env.sh
echo
echo Recreate domain: $DOMAIN_HOME
rm -rf $DOMAIN_HOME
rm -rf $APPLICATIONS_HOME
wlst.sh createFMwDomain.py -loadProperties fmw.properties
echo
echo Copy setUserOverrides.sh to: $DOMAIN_HOME/bin
cp setUserOverrides.sh $DOMAIN_HOME/bin