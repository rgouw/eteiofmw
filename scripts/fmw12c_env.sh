#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export DOMAIN_NAME=book_domain
export INSTANCE_NAME=bookInstance1
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/middleware
export ORACLE_COMMON_HOME=$ORACLE_HOME/oracle_common
export WL_HOME=$ORACLE_HOME/wlserver
export SOA_PROD_DIR=$ORACLE_HOME/soa
export CONTENT_PROD_DIR=$ORACLE_HOME/content
export PORTAL_PROD_DIR=$ORACLE_HOME/portal
export BPM_PROD_DIR=$ORACLE_HOME/bpm
export EM_DIR=$ORACLE_HOME/em
export JAVA_HOME=$ORACLE_BASE/product/jdk
export SHARED_CONFIG_DIR=/data/oracle/config
export ASERVER_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export MSERVER_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export APPLICATION_HOME=$SHARED_CONFIG_DIR/applications/$DOMAIN_NAME
export ORACLE_RUNTIME=/data/oracle/runtime
export NM_HOME=$SHARED_CONFIG_DIR/node_manager
export DEPLOY_PLAN_HOME=$SHARED_CONFIG_DIR/dp
export KEYSTORE_HOME=$SHARED_CONFIG_DIR/keystores
export OHS_ORACLE_HOME=$ORACLE_HOME
export OHS_DOMAIN_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export OHS_CONFIG_DIR=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME/config/fmwcomfig/components/OHS/$INSTANCE_NAME

#export SOA_HOME=$FMW_HOME/soa
#export OSB_HOME=$FMW_HOME/osb
#export MFT_HOME=$FMW_HOME/mft