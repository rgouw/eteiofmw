#!/bin/bash
echo set Database 12c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export DATABASE_HOME=/data/oracle/oradata
#
export ORACLE_SID=orcl
export DB_CONNECT_STR=darlin-vce:1521:${ORACLE_SID}
export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;
export TMP=/tmp
export TMPDIR=$TMP
