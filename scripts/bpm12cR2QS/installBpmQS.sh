#!/bin/bash
. $PWD/jdev12c_env.sh
echo JAVA_HOME=$JAVA_HOME
if [ ! -d "$JAVA_HOME" ]; then
  # Install jdk
  echo Install jdk 1.8
  sudo rpm -ihv ./jdk-8u74-linux-x64.rpm
else
  echo jdk 1.8 already installed
fi
# Install BPM QS
if [ ! -d "$JDEV_HOME" ]; then
  # Install JDeveloper BPM QuickStart
  echo Install JDeveloper BPM QuickStart 12cR2
  $JAVA_HOME/bin/java -jar fmw_12.2.1.0.0_bpm_quickstart.jar -silent -responseFile $PWD/bpmqs1221_silentInstall-lnx.rsp
else
  echo JDeveloper BPM QuickStart 12cR2 already installed
fi
echo copy jdev.boot naar $JDEV_HOME/jdeveloper/jdev/bin
mv $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot.org
cp $PWD/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/
echo copy JDeveloper BPM QuickStart 12cR2 environment and start scripts to ~/bin
cp $PWD/jdev12c_env.sh ~/bin 
cp $PWD/jdev12c.sh ~/bin

