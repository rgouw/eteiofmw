#!/bin/bash
. $PWD/fmw12c_env.sh
#
export OSB_ZIP_HOME=$PWD/../Zipped
export OSB_INSTALL_HOME=$PWD/../Extracted/stage
export OSB_INSTALL_JAR=fmw_12.2.1.1.0_osb.jar
export OSB_INSTALL_RSP=fmw_12.2.1.1.0_osb.rsp
export OSB_INSTALL_RSP_TPL=$OSB_INSTALL_RSP.tpl
export OSB_INSTALL_ZIP=fmw_12.2.1.1.0_osb_Disk1_1of1.zip
#
# ServiceBus 12c
if [[ -d "$FMW_HOME" && ! -d "$OSB_PROD_DIR/bin" ]]; then
  #
  #Unzip ServiceBus
  if [ ! -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    if [ -f "$OSB_ZIP_HOME/$OSB_INSTALL_ZIP" ]; then
      echo Unzip $OSB_ZIP_HOME/$OSB_INSTALL_ZIP to $OSB_INSTALL_HOME/$OSB_INSTALL_JAR
      unzip -o $OSB_ZIP_HOME/$OSB_INSTALL_ZIP -d $OSB_INSTALL_HOME
    else
      echo $OSB_INSTALL_HOME/$OSB_INSTALL_ZIP does not exist!
    fi  
  else
    echo $OSB_INSTALL_JAR already unzipped
  fi
  if [ -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    echo Substitute $OSB_INSTALL_RSP_TPL to $OSB_INSTALL_RSP
    envsubst < $OSB_INSTALL_RSP_TPL > $OSB_INSTALL_RSP
    echo Install ServiceBus 12cR2
    $JAVA_HOME/bin/java -jar $OSB_INSTALL_HOME/$OSB_INSTALL_JAR -silent -responseFile $PWD/$OSB_INSTALL_RSP
  else
    echo $OSB_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$OSB_PROD_DIR/bin" ]; then
    echo $OSB_PROD_DIR/bin available: ServiceBus Already installed
  fi
fi