#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export DOMAIN_NAME=fmw12c_domain
export OHS_DOMAIN_NAME=ohs_domain
export INSTANCE_NAME=ohs1
export ORACLE_BASE=/app/oracle
export DB_HOME=$ORACLE_BASE/product/databse/12.1.0/dbhome_1
export INVENTORY_DIRECTORY=/app/oraInventory
export FMW_HOME=$ORACLE_BASE/product/middleware/FMW12212
export FMW_COMMON_HOME=$FMW_HOME/oracle_common
export WL_HOME=$FMW_HOME/wlserver
export SOA_PROD_DIR=$FMW_HOME/soa
export WCC_PROD_DIR=$FMW_HOME/wccontent
export WCP_PROD_DIR=$FMW_HOME/wcportal
export BPM_PROD_DIR=$FMW_HOME/bpm
export OSB_PROD_DIR=$FMW_HOME/osb
export OHS_PROD_DIR=$FMW_HOME/ohs
export OHSSA_HOME=$ORACLE_BASE/product/middleware/OHS12212
export JDEVWC_PROD_DIR=$ORACLE_BASE/product/jdeveloper_wc
export JDEVBPM_PROD_DIR=$ORACLE_BASE/product/jdeveloper_bpm
export EM_DIR=$FMW_HOME/em
export JAVA_HOME=$ORACLE_BASE/product/jdk
#export SHARED_CONFIG_DIR=/data/oracle/config
export SHARED_CONFIG_DIR=/u01/app/work
export ASERVER_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export MSERVER_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export APPLICATION_HOME=$SHARED_CONFIG_DIR/applications/$DOMAIN_NAME
#export ORACLE_RUNTIME=/data/oracle/runtime
export ORACLE_RUNTIME=/u01/app/runtime
export NM_HOME=$SHARED_CONFIG_DIR/node_manager
export DEPLOY_PLAN_HOME=$SHARED_CONFIG_DIR/dp
export KEYSTORE_HOME=$SHARED_CONFIG_DIR/keystores
export OHS_ORACLE_HOME=$ORACLE_HOME
export OHS_DOMAIN_HOME=$SHARED_CONFIG_DIR/domains/$OHS_DOMAIN_NAME
export OHS_CONFIG_DIR=$SHARED_CONFIG_DIR/domains/$OHS_DOMAIN_NAME/config/fmwcomfig/components/OHS/$INSTANCE_NAME
#
#RCU
export RCU_COMPONENT_LIST=STB,SOAINFRA,CONTENTSEARCH,UCSUMS,CONTENT,MDS,CAPTURE,WLS,OPSS,IAU,IAU_APPEND,IAU_VIEWER,WEBCENTER,PORTLET,ACTIVITIES,DISCUSSIONS