#############################################################################
# Stop AdminServer 
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = 'stopAdmin.py'
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
def connectToadminServer( adminUrl, adminServerName):
  try:
    print(lineSeperator)
    print('Try to connect to the AdminServer using user config')
    connect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, url=adminUrl)
  except NameError, e:
    print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
    print('Try to connect to the AdminServer adminUser and adminPwd properties')
    connect(adminUser, adminPwd, adminUrl)
  except WLSTException:
    message='Apparently AdminServer not Started!'
    print (message)
    raise Exception(message)
#
#
def main():
  try:
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    print(lineSeperator)
    print('Stop '+adminServerName+' for domain in : '+wlsDomainHome)
    print(lineSeperator)
    print('\nConnect to the AdminServer: '+adminServerName)
    connectToadminServer(adminUrl, adminServerName)
    #
    print('\nShutdown the AdminServer: '+adminServerName)
    shutdown(force='true')
    #
    #print '\nConnect to the Node Manager'; 
    #connectToNM(adminUser, adminPwd, nmHost, nmPort, nmHome, soabpmDomainName, soabpmDomainHome, nmType);
    #
    #print '\nStop the NodeManager';
    #stopNodeManager();
    print('\nFinished stopping AdminServer: '+adminServerName)
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
