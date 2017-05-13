#!/bin/bash
echo Setting Database Environment
#export ORACLE_HOSTNAME=darlin-vce-db.darwin-it.local
#export ORACLE_UNQNAME=orcl.darwin-it.local
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
#export ORACLE_SID=book
export ORACLE_SID=orcl
export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;
export TMP=/tmp
export TMPDIR=$TMP
