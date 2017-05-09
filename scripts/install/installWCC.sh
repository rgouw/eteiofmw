#!/bin/bash
. $PWD/fmw12c_env.sh
#
export WCC_ZIP_HOME=$PWD/../../Zipped/WCC
export WCC_INSTALL_HOME=$PWD/../../Extracted/WCC
export WCC_INSTALL_JAR=fmw_12.2.1.2.0_wccontent.jar
export WCC_INSTALL_RSP=fmw_12.2.1.2.0_wccontent.rsp
export WCC_INSTALL_RSP_TPL=$WCC_INSTALL_RSP.tpl
#export WCC_INSTALL_ZIP=fmw_12.2.1.2.0_wccontent_Disk1_1of1.zip
export WCC_INSTALL_ZIP=V779244-01.zip
#
# WebCenter Content 12c
if [[ -d "$FMW_HOME" && ! -d "$WCC_PROD_DIR/common/bin" ]]; then
  #
  #Unzip WebCenter Content
  if [ ! -f "$WCC_INSTALL_HOME/$WCC_INSTALL_JAR" ]; then
    if [ -f "$WCC_ZIP_HOME/$WCC_INSTALL_ZIP" ]; then
      echo Unzip $WCC_ZIP_HOME/$WCC_INSTALL_ZIP to $WCC_INSTALL_HOME/$WCC_INSTALL_JAR
      unzip -o $WCC_ZIP_HOME/$WCC_INSTALL_ZIP -d $WCC_INSTALL_HOME
    else
      echo $WCC_INSTALL_HOME/$WCC_INSTALL_ZIP does not exist!
    fi  
  else
    echo $WCC_INSTALL_JAR already unzipped
  fi
  if [ -f "$WCC_INSTALL_HOME/$WCC_INSTALL_JAR" ]; then
    echo Substitute $WCC_INSTALL_RSP_TPL to $WCC_INSTALL_RSP
    envsubst < $WCC_INSTALL_RSP_TPL > $WCC_INSTALL_RSP
    echo Install WebCenter Content 12cR2
    $JAVA_HOME/bin/java -jar $WCC_INSTALL_HOME/$WCC_INSTALL_JAR -silent -responseFile $PWD/$WCC_INSTALL_RSP
  else
    echo $WCC_INSTALL_JAR not available!./
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo 7
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$WCC_PROD_DIR/common/bin" ]; then
    echo $WCC_PROD_DIR/common/bin available: WebCenter Content installed
  fi
fi
