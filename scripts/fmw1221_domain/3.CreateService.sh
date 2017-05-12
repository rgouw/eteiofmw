#!/bin/bash
echo
echo Run As Root!!!!
export SERVICE_SCRIPT=nodemanager_admin
export INITD_LOC=/etc/init.d
mv -f $SERVICE_SCRIPT $INITD_LOC
chmod +x $INITD_LOC/$SERVICE_SCRIPT
echo
echo Add Service $SERVICE_SCRIPT
chkconfig --add $SERVICE_SCRIPT
echo
echo Enable Service $SERVICE_SCRIPT
chkconfig $SERVICE_SCRIPT on
echo
echo Restart Service $SERVICE_SCRIPT
service $SERVICE_SCRIPT restart

