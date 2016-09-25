#############################################################################
# Stop nodemanager
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = 'stopNodeManager.py'
#
#
lineSeperator='__________________________________________________________________________________'
#
#
def usage():
  print 'Call script as: '
  print 'Windows: wlst.cmd '+scriptName+' -loadProperties localhost.properties'
  print 'Linux: wlst.sh '+scriptName+' -loadProperties environment.properties'
  print 'Property file should contain the following properties: '
  print "adminUrl=localhost:7101"
  print "adminUser=weblogic"
  print "adminPwd=welcome1"
# 
# 
def stopNM(adminUser, adminPwd, nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType):
  try:
    print(lineSeperator)
    print ('Try to connect to the Node Manager')
    nmConnect(username=adminUser, password=adminPwd, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType);
    print ('Connected to the Node Mananger')
    print ('Stop the NodeManager')
    stopNodeManager();
    print('Finished stapping NodeManager')
  except WLSTException:
    print ('Apparently NodeManager not Started!')
#
def main():
  try:
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    stopNM(adminUser, adminPwd, nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType);
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    stopEdit('y')
    exit(exitcode=1)
#
main()
