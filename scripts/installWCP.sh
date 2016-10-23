#!/bin/bash
. $PWD/fmw12c_env.sh
#
export WCP_ZIP_HOME=$PWD/../Zipped
export WCP_INSTALL_HOME=$PWD/../Extracted/stage
export WCP_INSTALL_JAR=fmw_12.2.1.2.0_wcportal.jar
export WCP_INSTALL_RSP=fmw_12.2.1.2.0_wcportal.rsp
export WCP_INSTALL_RSP_TPL=$WCP_INSTALL_RSP.tpl
export WCP_INSTALL_ZIP=fmw_12.2.1.2.0_wcportal_Disk1_1of1.zip
#
# WebCenter Portal 12c
if [[ -d "$FMW_HOME" && ! -d "$PORTAL_PROD_DIR/bin" ]]; then
  #
  #Unzip WebCenter Portal
  if [ ! -f "$WCP_INSTALL_HOME/$WCP_INSTALL_JAR" ]; then
    if [ -f "$WCP_ZIP_HOME/$WCP_INSTALL_ZIP" ]; then
      echo Unzip $WCP_ZIP_HOME/$WCP_INSTALL_ZIP to $WCP_INSTALL_HOME/$WCP_INSTALL_JAR
      unzip -o $WCP_ZIP_HOME/$WCP_INSTALL_ZIP -d $WCP_INSTALL_HOME
    else
      echo $WCP_INSTALL_HOME/$WCP_INSTALL_ZIP does not exist!
    fi  
  else
    echo $WCP_INSTALL_JAR already unzipped
  fi
  if [ -f "$WCP_INSTALL_HOME/$WCP_INSTALL_JAR" ]; then
    echo Substitute $WCP_INSTALL_RSP_TPL to $WCP_INSTALL_RSP
    envsubst < $WCP_INSTALL_RSP_TPL > $WCP_INSTALL_RSP
    echo Install WebCenter Portal 12cR2
    $JAVA_HOME/bin/java -jar $WCP_INSTALL_HOME/$WCP_INSTALL_JAR -silent -responseFile $PWD/$WCP_INSTALL_RSP
  else
    echo $WCP_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
echo 7
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$PORTAL_PROD_DIR/bin" ]; then
    echo $PORTAL_PROD_DIR/bin available: WebCenter Portal installed
  fi
fi
