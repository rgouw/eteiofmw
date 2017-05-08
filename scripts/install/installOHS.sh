#!/bin/bash
. $PWD/fmw12c_env.sh
#
export OHS_ZIP_HOME=$PWD/../../Zipped/OHS
export OHS_INSTALL_HOME=$PWD/../../Extracted/OHS
export OHS_INSTALL_BIN=fmw_12.2.1.2.0_ohs_linux64.bin
export OHS_INSTALL_RSP=fmw_12.2.1.2.0_ohs.rsp
export OHS_INSTALL_RSP_TPL=$OHS_INSTALL_RSP.tpl
export OHS_INSTALL_ZIP=V789368-01.zip
#
# Oracle Webtier 12c
if [[ -d "$FMW_HOME" && ! -d "$OHS_PROD_DIR/bin" ]]; then
  #
  #Unzip hs
  if [ ! -f "$OHS_INSTALL_HOME/$OHS_INSTALL_BIN" ]; then
    if [ -f "$OHS_ZIP_HOME/$OHS_INSTALL_ZIP" ]; then
      if [ ! -d "$OHS_INSTALL_HOME" ]; then
        echo Create folder "$OHS_INSTALL_HOME"
        mkdir -p "$OHS_INSTALL_HOME"
      fi
      echo Unzip $OHS_ZIP_HOME/$OHS_INSTALL_ZIP to $OHS_INSTALL_HOME/$OHS_INSTALL_BIN
      unzip -o $OHS_ZIP_HOME/$OHS_INSTALL_ZIP -d $OHS_INSTALL_HOME
    else
      echo $OHS_INSTALL_HOME/$OHS_INSTALL_ZIP does not exist!
    fi  
  else
    echo $OHS_INSTALL_BIN already unzipped
  fi
  if [ -f "$OHS_INSTALL_HOME/$OHS_INSTALL_BIN" ]; then
    echo Substitute $OHS_INSTALL_RSP_TPL to $OHS_INSTALL_RSP
    envsubst < $OHS_INSTALL_RSP_TPL > $OHS_INSTALL_RSP
    echo Install Oracle HTTP Server 12cR2
    $OHS_INSTALL_HOME/$OHS_INSTALL_BIN -silent -responseFile $PWD/$OHS_INSTALL_RSP
  else
    echo $OHS_INSTALL_BIN not available!
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middleware Infrastucture
  fi
  if [ -d "$OHS_PROD_DIR/bin" ]; then
    echo $OHS_PROD_DIR/bin available: WebTier installed
  fi
fi
