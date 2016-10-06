#!/bin/bash
. $PWD/fmw12c_env.sh
#
export JDEV_ZIP_HOME=$PWD/../Zipped
export JDEV_INSTALL_HOME=$PWD/../Extracted/stage
export JDEV_INSTALL_JAR=fmw_12.2.1.1.0_bpm_quickstart.jar
export JDEV_INSTALL_RSP=fmw_12.2.1.1.0_bpm_quickstart.rsp
export JDEV_INSTALL_RSP_TPL=$JDEV_INSTALL_RSP.tpl
### Need to check the name of the zip file.
export JDEV_INSTALL_ZIP=fmw_12.2.1.1.0_bpm_quickstart.zip
#
# Install BPM QS

if [ ! -d "$JDEVBPM_PROD_DIR" ]; then
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
    echo Install JDeveloper BPM QuickStart 12cR2
	$JAVA_HOME/bin/java -jar $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR -silent -responseFile $PWD/$JDEV_INSTALL_RSP
    echo copy jdev.boot naar $JDEV_HOME/jdeveloper/jdev/bin
    mv $JDEVBPM_PROD_DIR/jdeveloper/jdev/bin/jdev.boot $JDEVBPM_PROD_DIR/jdeveloper/jdev/bin/jdev.boot.org
    cp $PWD/jdevbpm.boot $JDEVBPM_PROD_DIR/jdeveloper/jdev/bin/jdev.boot
    echo copy JDeveloper BPM QuickStart 12cR2 environment and start scripts to ~/bin
	mkdir -p ~/bin/
    cp $PWD/jdevbpm12c_env.sh ~/bin/ 
    cp $PWD/jdevbpm12c.sh ~/bin/
  else
    echo $JDEV_INSTALL_JAR not available!.
  fi
else
  if [ -d "$JDEV_PROD_DIR" ]; then
    echo JDeveloper BPM QuickStart 12cR2 already installed
  fi
fi
