#!/bin/bash
. fmw12c_env.sh
echo Start AdminServer in background.
nohup $DOMAIN_HOME/startWebLogic.sh > $DOMAIN_HOME/bin/AdminServer.out 2>&1 &
tail -f $DOMAIN_HOME/bin/AdminServer.out
