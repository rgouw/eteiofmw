#!/bin/bash
. $PWD/fmw12c_env.sh
#
export FMW_INSTALL_HOME=/stage
export FMW_INSTALL_JAR=fmw_12.2.1.1.0_infrastructure.jar
export FMW_INSTALL_RSP=fmw_12.2.1.1.0_infrastructure.rsp
export FMW_INSTALL_ZIP=V78156-01.zip
#
# Fusion Middlware Infrastucture
if [ ! -d "$FMW_HOME" ]; then
  #Unzip FMW
  if [ ! -f "$FMW_INSTALL_HOME/$FMW_INSTALL_JAR" ]; then
    if [ -f "$FMW_INSTALL_HOME/$FMW_INSTALL_ZIP" ]; then
      echo Unzip $FMW_INSTALL_HOME/$FMW_INSTALL_ZIP to $FMW_INSTALL_HOME/$FMW_INSTALL_JAR
      unzip $FMW_INSTALL_HOME/$FMW_INSTALL_ZIP -d $FMW_INSTALL_HOME
    else
      echo $FMW_INSTALL_HOME/$FMW_INSTALL_ZIP does not exist
    fi  
  else
    echo $FMW_INSTALL_JAR already unzipped.
  fi
  if [ -f "$FMW_INSTALL_HOME/$FMW_INSTALL_JAR" ]; then
    echo Install Fusion Middleware Infrastucture 12cR2
    $JAVA_HOME/bin/java -jar $FMW_INSTALL_HOME/$FMW_INSTALL_JAR  -silent -responseFile $PWD/$FMW_INSTALL_RSP
  else    
	echo $FMW_INSTALL_JAR not available!
  fi  
else
  echo $FMW_HOME available: Fusion Middleware 12c Infrastucture already installed.
fi