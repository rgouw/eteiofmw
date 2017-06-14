#!/bin/bash
FORMAT='%-40s : %50s : %50s\n'
TABLE_SEPERATOR='--------------------------------------------------------------------------------------------------------------------------------------------------'
MEMORY_REQUIRED=`expr 16 \* 1024`
CPU_REQUIRED=4
HOSTNAME=`hostname`
echo 'Host: ' $HOSTNAME
echo 'Checking various OS settings...'
echo
printf "$FORMAT" 'name' 'preferred' 'current value'
echo $TABLE_SEPERATOR

NAME='Memory'
PREFERRED_VALUE=$MEMORY_REQUIRED
CURRENT_VALUE=`free -m | grep Mem | awk '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='CPU Threads'
PREFERRED_VALUE=$CPU_REQUIRED
CURRENT_VALUE=`mpstat | egrep '\(.* CPU\)' | awk '{print $6}' | sed -n 's/(//p'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='OS Version'
PREFERRED_VALUE='3.10.0-327.el7.x86_64'
CURRENT_VALUE=`uname -a | awk '{print $3}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Mount point /u01'
PREFERRED_VALUE='50G'
CURRENT_VALUE=`df -h | egrep '/u01$' | awk '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Mount point /u02'
PREFERRED_VALUE='50G'
CURRENT_VALUE=`df -h | egrep '/u02$' | awk '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Locale LANG'
PREFERRED_VALUE='en_US.utf8'
CURRENT_VALUE=`locale | grep 'LANG' | awk -F = '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Locale LC_ALL'
PREFERRED_VALUE='en_US.utf8'
CURRENT_VALUE=`locale | grep 'LC_ALL' | awk -F = '{print $2}'`
if [[ !  -z  $CURRENT_VALUE  ]]
then
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"
else
    NAME='Locale LC_CTYPE'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_CTYPE' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_NUMERIC'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_NUMERIC' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_TIME'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_TIME' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_COLLATE'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_COLLATE' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_MONETARY'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_MONETARY' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_MESSAGES'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_MESSAGES' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_PAPER'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_PAPER' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_NAME'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_NAME' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_ADDRESS'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_ADDRESS' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_TELEPHONE'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_TELEPHONE' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_MEASUREMENT'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_MEASUREMENT' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

    NAME='Locale LC_IDENTIFICATION'
    PREFERRED_VALUE='"en_US.utf8"'
    CURRENT_VALUE=`locale | grep 'LC_IDENTIFICATION' | awk -F = '{print $2}'`
    printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"
fi

NAME='Package binutils'
PREFERRED_VALUE='2.23.52.0.1.el7.x86_64'
CURRENT_VALUE=`rpm -qa binutils | grep .x86_64 | sed 's/binutils-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package compat-libcap1'
PREFERRED_VALUE='1.10.el7.x86_64'
CURRENT_VALUE=`rpm -qa compat-libcap1 | grep .x86_64 | sed 's/compat-libcap1-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package compat-libstdc++-33 i686'
PREFERRED_VALUE='3.2.3.el7.i686'
CURRENT_VALUE=`rpm -qa compat-libstdc++-33 | grep .i686 | sed 's/compat-libstdc++-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"


NAME='Package compat-libstdc++-33'
PREFERRED_VALUE='3.2.3.el7.x86_64'
CURRENT_VALUE=`rpm -qa compat-libstdc++-33 | grep .x86_64 | sed 's/compat-libstdc++-33-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package gcc'
PREFERRED_VALUE='4.8.2.el7.x86_64'
CURRENT_VALUE=`rpm -qa gcc | grep .x86_64 | sed 's/gcc-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package gcc-c++'
PREFERRED_VALUE='4.8.2.el7.x86_64'
CURRENT_VALUE=`rpm -qa gcc-c++ | grep .x86_64 | sed 's/gcc-c++-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package glibc i686'
PREFERRED_VALUE='2.17.el7.i686'
CURRENT_VALUE=`rpm -qa glibc | grep .i686 | sed 's/glibc-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package glibc'
PREFERRED_VALUE='2.17.el7.x86_64'
CURRENT_VALUE=`rpm -qa glibc | grep .x86_64 | sed 's/glibc-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package glibc-devel'
PREFERRED_VALUE='2.17.el7.x86_64'
CURRENT_VALUE=`rpm -qa glibc-devel | grep .x86_64 | sed 's/glibc-devel-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package ksh'
PREFERRED_VALUE='.el7.x86_64'
CURRENT_VALUE=`rpm -qa ksh | grep .x86_64 | sed 's/ksh.//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libaio'
PREFERRED_VALUE='0.3.109.el7.x86_64'
CURRENT_VALUE=`rpm -qa libaio | grep .x86_64 | sed 's/libaio-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libaio-devel'
PREFERRED_VALUE='0.3.109.el7.x86_64'
CURRENT_VALUE=`rpm -qa libaio-devel | grep .x86_64 | sed 's/libaio-devel-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libgcc i686'
PREFERRED_VALUE='4.8.2.el7.i686'
CURRENT_VALUE=`rpm -qa libgcc | grep .i686 | sed 's/libgcc-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libgcc'
PREFERRED_VALUE='4.8.2.el7.x86_64'
CURRENT_VALUE=`rpm -qa libgcc | grep .x86_64 | sed 's/libgcc-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libstdc++ i686'
PREFERRED_VALUE='4.8.2.el7.i686'
CURRENT_VALUE=`rpm -qa libstdc++ | grep .i686 | sed 's/libstdc++-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libstdc++'
PREFERRED_VALUE='4.8.2.el7.x86_64'
CURRENT_VALUE=`rpm -qa libstdc++ | grep .x86_64 | sed 's/libstdc++-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libstdc++-devel'
PREFERRED_VALUE='4.8.2.el7.x86_64'
CURRENT_VALUE=`rpm -qa libstdc++-devel | grep .x86_64 | sed 's/libstdc++-devel-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package make'
PREFERRED_VALUE='3.82.el7.x86_64'
CURRENT_VALUE=`rpm -qa make | grep .x86_64 | sed 's/make-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package motif'
PREFERRED_VALUE='2.3.4.el7.x86_64'
CURRENT_VALUE=`rpm -qa motif | grep .x86_64 | sed 's/motif-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package motif-devel'
PREFERRED_VALUE='2.3.4.el7.x86_64'
CURRENT_VALUE=`rpm -qa motif-devel | grep .x86_64 | sed 's/motif-devel-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package numactl'
PREFERRED_VALUE='2.0.9.el7.x86_64'
CURRENT_VALUE=`rpm -qa numactl | grep .x86_64 | sed 's/numactl-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package numactl-devel'
PREFERRED_VALUE='2.0.9.el7.x86_64'
CURRENT_VALUE=`rpm -qa numactl-devel | grep .x86_64 | sed 's/numactl-devel-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package sysstat'
PREFERRED_VALUE='10.1.5.el7.x86_64'
CURRENT_VALUE=`rpm -qa sysstat | grep .x86_64 | sed 's/sysstat-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package unzip'
PREFERRED_VALUE='15.el7.x86_64'
CURRENT_VALUE=`rpm -qa unzip | grep .x86_64 | sed 's/unzip-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package xorg-x11-utils'
PREFERRED_VALUE='7.5-14.el7.x86_64'
CURRENT_VALUE=`rpm -qa xorg-x11-utils | grep .x86_64 | sed 's/xorg-x11-utils-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Package libXtst'
PREFERRED_VALUE='1.2.1-2.1.el7.x86_64'
CURRENT_VALUE=`rpm -qa libXtst | grep .x86_64 | sed 's/libXtst-//'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='SUDO priviledges'
PREFERRED_VALUE='(ALL) NOPASSWD: ALL'
CURRENT_VALUE=`sudo -l | grep "(ALL) NOPASSWD: ALL"`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Available entropy'
PREFERRED_VALUE='>1000'
for i in {1..100}
do
    ENTROPY=`cat /proc/sys/kernel/random/entropy_avail`
    sleep .01
done
CURRENT_VALUE=$ENTROPY
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='Local firewall status'
PREFERRED_VALUE='inactive (dead)'
CURRENT_VALUE=`systemctl status firewalld 2>/dev/null | grep Active | awk '{print $2, $3}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='haveged daemon (auto start)'
PREFERRED_VALUE=' enabled'
CURRENT_VALUE=`systemctl status haveged 2>/dev/null | grep Loaded | awk -F ';' '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

NAME='ntpd daemon (auto start)'
PREFERRED_VALUE=' enabled'
CURRENT_VALUE=`systemctl status ntpd 2>/dev/null | grep Loaded | awk -F ';' '{print $2}'`
printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"

VIPS=`ip addr show | grep 'secondary eth2' | awk -F '[ /]+' '{print $3}'`
INDEX=1
for VIP in $VIPS
do
  NAME=VIP_$INDEX
  PREFERRED_VALUE='?'
  CURRENT_VALUE=`nslookup $VIP | grep "name = " | awk -F '(.in-addr.arpa)|[ ]+' '{print $4}' 2>/dev/null | sed 's/.$//'`
  CURRENT_VALUE="$CURRENT_VALUE = $VIP"
  printf "$FORMAT" "$NAME" "$PREFERRED_VALUE" "$CURRENT_VALUE"
  INDEX=$((INDEX+1))
done

echo $TABLE_SEPERATOR
