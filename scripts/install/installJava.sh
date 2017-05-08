#!/bin/bash
. $PWD/fmw12c_env.sh
#
export TMP_DIR=/tmp
export JAVA_ZIP_HOME=$PWD/../../Zipped/Java
export JAVA_INSTALL_HOME=$PWD/../../Extracted/Java
export JAVA_INSTALL_TMP=$TMP_DIR/jdk
export JAVA_INSTALL_ZIP=p25767248_180131_Linux-x86-64.zip
export JAVA_INSTALL_TAR=jdk-8u131-linux-x64.tar.gz
export JAVA_INSTALL_NAME=jdk1.8.0_131

#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
 #
  #Unzip Java
  if [ ! -f "$JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR" ]; then
    if [ -f "$JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP" ]; then
      echo Unzip $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP  to $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR
      mkdir -p $JAVA_INSTALL_HOME
      unzip -o $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP -d $JAVA_INSTALL_HOME
    else
      echo $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP does not exist!
    fi  
  else
    echo $JAVA_INSTALL_TAR already unzipped
  fi
  # Install jdk
  echo Install jdk 
  mkdir -p $JAVA_INSTALL_TMP
  tar -xf $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR -C $JAVA_INSTALL_TMP
  mv  $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME $JAVA_HOME
  #cp -R $JAVA_INSTALL_RPM/* $JAVA_HOME
  #sudo rpm -ihv $JAVA_INSTALL_HOME/$JAVA_INSTALL_RPM 
else
  echo jdk 1.8 already installed
fi