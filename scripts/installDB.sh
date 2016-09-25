#!/bin/bash
. $PWD/fmw12c_env.sh
export DATABASE_HOME=/app/oracle/product/database/dbhome_1
export DATABASE_INSTALL_HOME=/stage/database
#
echo DATABASE_HOME=$DATABASE_HOME
if [ ! -f "$DATABASE_HOME/bin/oraping" ]; then
  # Install Database
  echo Install Database
  $DATABASE_INSTALL_HOME/runInstaller -silent -responseFile /home/scripts/db.rsp  
  sudo /data/oracle/oraInventory/orainstRoot.sh
  sudo /app/oracle/product/database/dbhome_1/root.sh
  /app/oracle/product/database/dbhome_1/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/home/scrips/db.rsp
else
  echo Database already installed
fi


