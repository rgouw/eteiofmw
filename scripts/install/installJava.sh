#!/bin/bash
. $PWD/fmw12c_env.sh
#
export JAVA_INSTALL_HOME=$PWD/../Java
export JAVA_INSTALL_RPM=$PWD/../Extracted/stage/jdk1.8.0_102
#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
  # Install jdk
  echo Install jdk 
  mkdir -p $JAVA_HOME
  cp -R $JAVA_INSTALL_RPM/* $JAVA_HOME
else
  echo jdk already installed
fi