#############################################################################
# Start OSB cluster
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.1, 2016-06-27
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = sys.argv[0]
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
  print "adminUrl=localhost:7001"
  print "adminUser=weblogic"
  print "adminPwd=welcome1"
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
    message='Apparently AdminServer not Started!'
    print (message)
    raise Exception(message)
#
# Get the Servers of Cluster 
def getClusterServers(clustername):
  #Cluster config to be fetched from ServerConfig
  print(lineSeperator)
  print('\nGet Servers from cluster '+clustername)
  serverConfig()
  cluster = getMBean("/Clusters/" + clustername)
  if cluster is None:
    errorMsg= "Cluster " + clustername + " does not appear to exist!"
    print errorMsg
    raise(Exception(errorMsg))
  print "Found cluster "+ clustername+ "."
  servers = cluster.getServers()
  return servers
#
#
def serverStatus(serverName):
  serverRuntime=getMBean('/ServerRuntimes/'+serverName)
  if serverRuntime is None:
    print("Server Runtime for  " + serverName + " not found, server apparently SHUTDOWN")
    serverState="SHUTDOWN"
  else:
    print "Found Server Runtime for "+ serverName+ "."
    serverState = serverRuntime.getState()
  return serverState
#
#
def startClusterServers(clusterName):
  print(lineSeperator)
  print ('Start servers for cluster: '+clusterName)
  servers=getClusterServers(clusterName)
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for server in servers:
    print(lineSeperator)
    serverName = server.getName()
    print('ServerName: '+serverName)
    serverState = serverStatus(serverName)
    print('Server '+serverName+': '+serverState)
    if serverState=="SHUTDOWN":
      print ('Server '+serverName+' is not running so start it.')
      start(serverName)
    elif serverState=="RUNNING":
      print ('Server '+serverName+' is already running')
    else:
      print ('Server '+serverName+' in state '+serverState+', not startable!')
  #
  print ('\nFinished starting servers.')
#
#
def main():
  try:
    print (lineSeperator)
    print ('Start Osb Cluster')
    print (lineSeperator)
    print('\nConnect to AdminServer ')
    connectToadminServer(adminUrl, adminServerName)
    #
    #Start servers for cluster
    startClusterServers(osbClr)
    #
    print('\nExiting...')
    exit()
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    stopEdit('y')
    exit(exitcode=1)
#call main()
main()
exit()