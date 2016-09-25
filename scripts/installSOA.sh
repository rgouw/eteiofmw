#!/bin/bash
. $PWD/fmw12c_env.sh
#
export SOA_INSTALL_HOME=$PWD/../SOASuiteAndBPM
export SOA_INSTALL_JAR=fmw_12.2.1.0.0_soa.jar
export SOA_INSTALL_RSP=fmw_12.2.1.0.0_soa.rsp
export SOA_INSTALL_ZIP=V78169-01.zip
#
# SOA and BPM Suite 12c
if [[ -d "$FMW_HOME" && ! -d "$SOA_HOME" ]]; then
  #
  #Unzip SOA&BPM
  if [ ! -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    if [ -f "$SOA_INSTALL_HOME/$SOA_INSTALL_ZIP" ]; then
      echo Unzip $SOA_INSTALL_HOME/$SOA_INSTALL_ZIP to $SOA_INSTALL_HOME/$SOA_INSTALL_JAR
      unzip $SOA_INSTALL_HOME/$SOA_INSTALL_ZIP -d $SOA_INSTALL_HOME
    else
      echo $SOA_INSTALL_HOME/$SOA_INSTALL_ZIP does not exist!
    fi  
  else
    echo $SOA_INSTALL_JAR already unzipped
  fi
  if [ -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    echo Install SOA and BPM Suite 12cR2
    $JAVA_HOME/bin/java -jar $SOA_INSTALL_HOME/$SOA_INSTALL_JAR -silent -responseFile $SOA_INSTALL_HOME/$SOA_INSTALL_RSP
  else
    echo $SOA_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$SOA_HOME" ]; then
    echo $SOA_HOME available: SOA Already installed
  fi
fi