#!/bin/bash
. $PWD/fmw12c_env.sh
export JAVA_INSTALL_HOME=$PWD/../Java
export JAVA_INSTALL_RPM=jdk-8u101-linux-x64.rpm
#
echo JAVA_HOME=$JAVA_HOME
if [ ! -d "$JAVA_HOME" ]; then
  # Install jdk
  echo Install jdk 1.8
  sudo rpm -ihv $JAVA_INSTALL_HOME/$JAVA_INSTALL_RPM
else
  echo jdk 1.8 already installed
fi