#!/bin/bash
. $PWD/db12c_env.sh
export DB_ZIP_HOME=$PWD/../Zipped
export DB_INSTALL_ZIP1=V46095-01_1of2.zip
export DB_INSTALL_ZIP2=V46095-01_2of2.zip
export DB_INSTALL_HOME=$PWD/../Extracted
export DB_RSP=$PWD/db12c.rsp
#
echo ORACLE_HOME=$ORACLE_HOME
if [ ! -f "$ORACLE_HOME/bin/oraping" ]; then
  #Unzip DB12
  if [ ! -f "$DB_INSTALL_HOME/database/runInstaller" ]; then
    if [[ -f "$DB_ZIP_HOME/$DB_INSTALL_ZIP1" && -f "$DB_ZIP_HOME/$DB_INSTALL_ZIP2" ]]; then
      echo Unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP1 to $DB_INSTALL_HOME
      unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP1 -d $DB_INSTALL_HOME
      echo Unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP2 to $DB_INSTALL_HOME
      unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP2 -d $DB_INSTALL_HOME
    else
      echo $DB_ZIP_HOME/$DB_INSTALL_ZIP1 and/or $DB_ZIP_HOME/$DB_INSTALL_ZIP1 do not exist
    fi  
  else
    echo $DB_INSTALL_HOME/database/runInstaller unzipped.
  fi
  # Install Database
  echo Install Database
  $DB_INSTALL_HOME/database/runInstaller -silent -responseFile $DB_RSP
  sudo /data/oracle/oraInventory/orainstRoot.sh
  sudo $ORACLE_HOME/root.sh
  $ORACLE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=$DB_RSP
else
  echo Database already installed
fi