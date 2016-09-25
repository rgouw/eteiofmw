#!/bin/bash
. $PWD/fmw12c_env.sh
#
export OSB_INSTALL_HOME=$PWD/../ServiceBus
export OSB_INSTALL_JAR=fmw_12.2.1.0.0_osb.jar
export OSB_INSTALL_RSP=fmw_12.2.1.0.0_osb.rsp
export OSB_INSTALL_ZIP=V78173-01.zip
#
# ServiceBus 12c
if [[ -d "$FMW_HOME" && ! -d "$OSB_HOME/bin" ]]; then
  #
  #Unzip ServiceBus
  if [ ! -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    if [ -f "$OSB_INSTALL_HOME/$OSB_INSTALL_ZIP" ]; then
      echo Unzip $OSB_INSTALL_HOME/$OSB_INSTALL_ZIP to $OSB_INSTALL_HOME/$OSB_INSTALL_JAR
      unzip $OSB_INSTALL_HOME/$OSB_INSTALL_ZIP -d $OSB_INSTALL_HOME
    else
      echo $OSB_INSTALL_HOME/$OSB_INSTALL_ZIP does not exist!
    fi  
  else
    echo $OSB_INSTALL_JAR already unzipped
  fi
  if [ -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    echo Install ServiceBus 12cR2
    $JAVA_HOME/bin/java -jar $OSB_INSTALL_HOME/$OSB_INSTALL_JAR -silent -responseFile $OSB_INSTALL_HOME/$OSB_INSTALL_RSP
  else
    echo $OSB_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$OSB_HOME" ]; then
    echo $OSB_HOME available: ServiceBus Already installed
  fi
fi