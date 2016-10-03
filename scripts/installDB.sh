#!/bin/bash
. $PWD/db12c_install_env.sh
#
export DB_ZIP_HOME=$PWD/../Zipped
export DB_INSTALL_HOME=$PWD/../Extracted/stage
export DB_INSTALL_RSP=db12c_software.rsp
export DB_INSTALL_RSP_TPL=$DB_INSTALL_RSP.tpl
export DB_INSTALL_ZIP1=V46095-01_1of2.zip
export DB_INSTALL_ZIP2=V46095-01_2of2.zip
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
  echo Substitute $DB_INSTALL_RSP_TPL to $DB_INSTALL_RSP
  envsubst < $DB_INSTALL_RSP_TPL > $DB_INSTALL_RSP
  echo Starting the Oracle Installer with command line: $DB_INSTALL_HOME/database/runInstaller -silent -responseFile $PWD/$DB_INSTALL_RSP
  #$DB_INSTALL_HOME/database/runInstaller -silent -ignorePrereq -responseFile $PWD/$DB_INSTALL_RSP
  #while pgrep -u oracle oracle.installer.library_loc > /dev/null; do sleep 1; done
  #sudo $INVENTORY_DIRECTORY/orainstRoot.sh
  #sudo $ORACLE_HOME/root.sh
  $ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname book -sid book -responseFile NO_VALUE -characterSet AL32UTF8 -memoryPercentage 30 -emConfiguration LOCAL -SysPassword welcome1 -SystemPassword welcome1 
  cp $PWD/*.ora $ORACLE_HOME/network/admin/
  #$ORACLE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=$DB_RSP
else
  echo Database already installed
fi