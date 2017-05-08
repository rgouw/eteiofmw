#!/bin/bash
#
# Script to create a OS group and user
# The script is using the file /home/root/oracle.properties to read the properties you can set, such as the password
#
SCRIPTPATH=$(dirname $0)

ENV=${1:-dev}

function prop {
    grep "${1}" $SCRIPTPATH/makeOracleUser.properties|cut -d'=' -f2
}

# As we are using the database as well, we need a group named dba
echo Creating group dba
/usr/sbin/groupadd -g 2001 dba

# We also need a group named oinstall as Oracle Inventory group
echo create group oinstall
/usr/sbin/groupadd -g 2000 oinstall

#
# Create the Oracle user
echo Create the oracle user
/usr/sbin/useradd -u 2000 -g oinstall -G dba oracle
echo Setting the oracle password to...
echo $(prop 'oracle.password') |passwd oracle --stdin
chown oracle:oinstall /app
#
# Add Oracle to sudoers so he can perform admin tasks
echo Adding oracle user to sudo-ers.
echo 'oracle           ALL=NOPASSWD:        ALL' >> /etc/sudoers
#
# Create oraInst.loc and grant to Oracle
echo "" > /etc/oraInst.loc
chown oracle:oinstall /etc/oraInst.loc
