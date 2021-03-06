#############################################################################
# Create a FMW domain
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.1, 2016-06-23
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = sys.argv[0]
#
#Home Folders
domainHome   = domainsHome+'/'+domainName
nodeManagerHome = domainHome+'/'+'nodemanager'
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
def main():
  try:
    #
    # Section 1: Base Domain + Admin Server
    print (lineSeperator)
    print ('Enroll '+domainName+' for NodeManager')
    print('\nConnect to AdminServer ')
    print (lineSeperator)
    adminURL=adminListenAddress+':'+adminListenPort
    connect(adminUser, adminPwd, adminURL)
    #
    print('\nPerform nmEnroll')
    print (lineSeperator)
    #
    nmEnroll(domainHome, nodeManagerHome)
    #
    print ('\nFinished')
    #
    print('\nExiting...')
    exit()
  except NameError, e:
    print 'Apparently properties not set.'
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    stopEdit('y')
    exit(exitcode=1)
#call main()
main()
exit()
