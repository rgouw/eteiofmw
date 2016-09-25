#############################################################################
# Start AdminServer via NodeManager and try to connect to it.
# Result of this script should be that you are connect to the AdminServer.
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = 'startAdmin.py'
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
def connectToNM(nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType):
  try:
    print(lineSeperator)
    print('Try to connect to the Node Manager')
    try:
      nmConnect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the NodeManager adminUser and adminPwd properties')
      nmConnect(username=adminUser, password=adminPwd, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    print('Connected to the Node Mananger')
  except WLSTException:
    message='Apparently NodeManager not Started!'
    print (message)
    raise Exception(message)
    #print 'Start Nodemanager'
    #startNodeManager(verbose='true', NodeManagerHome=nmHome, ListenPort=nmPort, ListenAddress=nmHost);
    #print 'Retry to connect to the Node Manager';
    #nmConnect(username=adminUser, password=adminPwd, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType);
#
#
def connectToadminServer(adminUrl, adminServerName):
  try:
    print(lineSeperator)
    print('Try to connect to the AdminServer')
    try:
      connect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, url=adminUrl)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the AdminServer adminUser and adminPwd properties')
      connect(adminUser, adminPwd, adminUrl)
  except WLSTException:
    print('Apparently AdminServer not Started!')
    print('Start AdminServer')
    nmStart(adminServerName)
    print('Retry to connect to the AdminServer')
    try:
      connect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, url=adminUrl)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the AdminServer adminUser and adminPwd properties')
      connect(adminUser, adminPwd, adminUrl)
#
#
def main():
  try:
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    print(lineSeperator)
    print('Start '+adminServerName+' for domain in : '+wlsDomainHome)
    print(lineSeperator)
    print ('Connect to the Node Manager')
    connectToNM(nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType)
    print ('Connect to the AdminServer: '+adminServerName)
    connectToadminServer(adminUrl, adminServerName)
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    stopEdit('y')
    exit(exitcode=1)
#
main();
