#!/bin/bash
. $PWD/fmw12c_env.sh
#
export SOA_ZIP_HOME=$PWD/../Zipped
export SOA_INSTALL_HOME=$PWD/../Extracted/stage
export SOA_INSTALL_JAR=fmw_12.2.1.2.0_soa.jar
export SOA_INSTALL_RSP=fmw_12.2.1.2.0_soa.rsp
export SOA_INSTALL_RSP_TPL=$SOA_INSTALL_RSP.tpl
export SOA_INSTALL_ZIP=fmw_12.2.1.2.0_soa_Disk1_1of1.zip
#Set this variable value to the Installation Type selected. e.g. SOA Suite, BPM.
export SOABPM_INSTALL_TYPE=BPM
#
# SOA and BPM Suite 12c
if [[ -d "$FMW_HOME" && ! -d "$SOA_PROD_DIR" ]]; then
  #
  #Unzip SOA&BPM
  if [ ! -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    if [ -f "$SOA_ZIP_HOME/$SOA_INSTALL_ZIP" ]; then
      echo Unzip $SOA_ZIP_HOME/$SOA_INSTALL_ZIP to $SOA_INSTALL_HOME/$SOA_INSTALL_JAR
      unzip -o $SOA_ZIP_HOME/$SOA_INSTALL_ZIP -d $SOA_INSTALL_HOME
    else
      echo $SOA_ZIP_HOME/$SOA_INSTALL_ZIP does not exist!
    fi  
  else
    echo $SOA_INSTALL_JAR already unzipped
  fi
  if [ -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    echo Substitute $SOA_INSTALL_RSP_TPL to $SOA_INSTALL_RSP
    envsubst < $SOA_INSTALL_RSP_TPL > $SOA_INSTALL_RSP
    echo Install SOA and BPM Suite 12cR2
    $JAVA_HOME/bin/java -jar $SOA_INSTALL_HOME/$SOA_INSTALL_JAR -silent -responseFile $PWD/$SOA_INSTALL_RSP
  else
    echo $SOA_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$SOA_PROD_DIR" ]; then
    echo $SOA_PROD_DIR available: SOA Already installed
  fi
fi