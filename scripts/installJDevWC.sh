#!/bin/bash
. $PWD/fmw12c_env.sh
#
export JDEV_ZIP_HOME=$PWD/../Zipped
export JDEV_INSTALL_HOME=$PWD/../Extracted/stage
export JDEV_INSTALL_JAR=jdev_suite_122110.jar
export JDEV_INSTALL_RSP=jdev_suite_122110.rsp
export JDEV_INSTALL_RSP_TPL=$JDEV_INSTALL_RSP.tpl
export JDEV_INSTALL_ZIP=fmw_12.2.1.1.0_jdev_Disk1_1of1.zip
#
# JDeveloper 
if [ ! -d "$JDEV_PROD_DIR" ]; then
  #
  #Unzip JDeveloper
  if [ ! -f "$JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR" ]; then
    if [ -f "$JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP" ]; then
      echo Unzip $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP to $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR
      unzip -o $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP -d $JDEV_INSTALL_HOME
    else
      echo $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP does not exist!
    fi  
  else
    echo $JDEV_INSTALL_JAR already unzipped
  fi
  if [ -f "$JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR" ]; then
    echo Substitute $JDEV_INSTALL_RSP_TPL to $JDEV_INSTALL_RSP
    envsubst < $JDEV_INSTALL_RSP_TPL > $JDEV_INSTALL_RSP
    echo Install JDeveloper 12cR2
    $JAVA_HOME/bin/java -jar $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR -silent -responseFile $PWD/$JDEV_INSTALL_RSP
  else
    echo $JDEV_INSTALL_JAR not available!./
  fi
else
  if [ -d "$JDEV_PROD_DIR" ]; then
    echo $JDEV_PROD_DIR available: JDeveloper Already installed
  fi
fi