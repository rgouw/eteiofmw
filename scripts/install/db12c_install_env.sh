#!/bin/bash
echo set Database 12c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export DATABASE_HOME=/data/oracle/oradata
export ORACLE_HOSTNAME=dbhost
export INVENTORY_DIRECTORY=/app/oraInventory
