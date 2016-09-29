#!/bin/bash
. $PWD/fmw12c_env.sh
export DATABASE_HOME=/app/oracle/product/database/dbhome_1
export DATABASE_INSTALL_HOME=/stage/database
export DATABASE_RSP=/home/scripts/db.rsp
#
echo DATABASE_HOME=$DATABASE_HOME
if [ ! -f "$DATABASE_HOME/bin/oraping" ]; then
  # Install Database
  echo Install Database
  $DATABASE_INSTALL_HOME/runInstaller -silent -responseFile $DATABASE_RSP
  sudo /data/oracle/oraInventory/orainstRoot.sh
  sudo $DATABASE_HOME/root.sh
  $DATABASE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=$DATABASE_RSP
else
  echo Database already installed
fi


