#############################################################################
# Create a SOA/BPM/OSB domain
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2016-04-06
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = sys.argv[0]
#
#Home Folders
wlsHome    = fmwHome+'/wlserver'
soaDomainHome       = domainsHome+'/'+soaDomainName
soaApplicationsHome = applicationsHome+'/'+soaDomainName
#
# Templates for 12.2.1
# See also https://docs.oracle.com/middleware/12211/lcm/WLDTR/toc.htm
wlsjar =fmwHome+'/wlserver/common/templates/wls/wls.jar'
oracleCommonTplHome=fmwHome+'/oracle_common/common/templates'
wlservicetpl=oracleCommonTplHome+'/wls/oracle.wls-webservice-template.jar'
#wsmpmtpl=oracleCommonTplHome+'/wls/oracle.wsmpm_template.jar'
osbtpl=fmwHome+'/osb/common/templates/wls/oracle.osb_template.jar'
applCoreTpl=oracleCommonTplHome+'/wls/oracle.applcore.model.stub_template.jar'
soatpl=fmwHome+'/soa/common/templates/wls/oracle.soa_template.jar'
bamtpl=fmwHome+'/soa/common/templates/wls/oracle.bam.server_template.jar'
bpmtpl=fmwHome+'/soa/common/templates/wls/oracle.bpm_template.jar'
ohsTpl=fmwHome+'/ohs/common/templates/wls/ohs_managed_template.jar' # need to be validated!
b2bTpl=fmwHome+'/soa/common/templates/wls/oracle.soa.b2b_template.jar' # need to be validated!
#
# ServerGroup definitions
adminSvrGrpDesc='WSM-CACHE-SVR WSMPM-MAN-SVR JRF-MAN-SVR'
adminSvrGrp=["WSM-CACHE-SVR" , "WSMPM-MAN-SVR" , "JRF-MAN-SVR"]
#
# OSB server groups with WSM-Policy Manager
#osbSvrGrpDesc="OSB-MGD-SVRS-COMBINED"
#osbSvrGrp=["OSB-MGD-SVRS-COMBINED"]
# OSB server groups without WSM-Policy Manager
osbSvrGrpDesc="OSB-MGD-SVRS-ONLY"
osbSvrGrp=["OSB-MGD-SVRS-ONLY"]
#
# SOA server groups with WSM-Policy Manager
#soaSvrGrpDesc="SOA-MGD-SVRS"
#soaSvrGrp=["SOA-MGD-SVRS"]
# SOA server groups without WSM-Policy Manager
soaSvrGrpDesc="SOA-MGD-SVRS-ONLY"
soaSvrGrp=["SOA-MGD-SVRS-ONLY"]
#
wsmSvrGrpDesc='WSMPM-MAN-SVR JRF-MAN-SVR WSM-CACHE-SVR'
wsmSvrGrp=["WSMPM-MAN-SVR", "JRF-MAN-SVR", "WSM-CACHE-SVR"]
#
# BAM server groups with WSM-Policy Manager
#bamSvrGrpDesc="BAM12-MGD-SVRS"
#bamSvrGrp=["BAM12-MGD-SVRS"]
# BAM server groups without WSM-Policy Manager
bamSvrGrpDesc="BAM12-MGD-SVRS-ONLY"
bamSvrGrp=["BAM12-MGD-SVRS-ONLY"]
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
# Create a boot properties file.
def createBootPropertiesFile(directoryPath,fileName, username, password):
  print ('Create Boot Properties File for folder: '+directoryPath)
  print (lineSeperator)
  serverDir = File(directoryPath)
  bool = serverDir.mkdirs()
  fileNew=open(directoryPath + '/'+fileName, 'w')
  fileNew.write('username=%s\n' % username)
  fileNew.write('password=%s\n' % password)
  fileNew.flush()
  fileNew.close()
#
# Create Startup Properties File
def createAdminStartupPropertiesFile(directoryPath, args):
  print 'Create AdminServer Boot Properties File for folder: '+directoryPath
  print (lineSeperator)
  adminserverDir = File(directoryPath)
  bool = adminserverDir.mkdirs()
  fileNew=open(directoryPath + '/startup.properties', 'w')
  args=args.replace(':','\\:')
  args=args.replace('=','\\=')
  fileNew.write('Arguments=%s\n' % args)
  fileNew.flush()
  fileNew.close()
 #
# Set Log properties
def setLogProperties(logMBeanPath, logFile, fileCount, fileMinSize, rotationType, fileTimeSpan):
  print '\nSet Log Properties for: '+logMBeanPath
  print (lineSeperator)
  cd(logMBeanPath)
  print ('Server log path: '+pwd())
  print '. set FileName to '+logFile
  set('FileName'    ,logFile)
  print '. set FileCount to '+str(fileCount)
  set('FileCount'   ,int(fileCount))
  print '. set FileMinSize to '+str(fileMinSize)
  set('FileMinSize' ,int(fileMinSize))
  print '. set RotationType to '+rotationType
  set('RotationType',rotationType)
  print '. set FileTimeSpan to '+str(fileTimeSpan)
  set('FileTimeSpan',int(fileTimeSpan))
#
#
def createServerLog(serverName, logFile, fileCount, fileMinSize, rotationType, fileTimeSpan):
  print ('\nCreate Log for '+serverName)
  print (lineSeperator)
  cd('/Server/'+serverName)
  create(serverName,'Log')
  setLogProperties('/Server/'+serverName+'/Log/'+serverName, logFile, fileCount, fileMinSize, rotationType, fileTimeSpan)
#
# Change DataSource to XA
def changeDatasourceToXA(datasource):
  print 'Change datasource '+datasource
  print (lineSeperator)
  cd('/')
  cd('/JDBCSystemResource/'+datasource+'/JdbcResource/'+datasource+'/JDBCDriverParams/NO_NAME_0')
  set('DriverName','oracle.jdbc.xa.client.OracleXADataSource')
  print '. Set UseXADataSourceInterface='+'True'
  set('UseXADataSourceInterface','True') 
  cd('/JDBCSystemResource/'+datasource+'/JdbcResource/'+datasource+'/JDBCDataSourceParams/NO_NAME_0')
  print '. Set GlobalTransactionsProtocol='+'TwoPhaseCommit'
  set('GlobalTransactionsProtocol','TwoPhaseCommit')
  cd('/')
#
#
def createCluster(cluster):
  print ('\nCreate '+cluster)
  print (lineSeperator)
  cd('/')
  create(cluster, 'Cluster')
#
# Create a Unix Machine
def createUnixMachine(serverMachine,serverAddress):
  print('\nCreate machine '+serverMachine+' with type UnixMachine')
  print (lineSeperator)
  cd('/')
  create(serverMachine,'UnixMachine')
  cd('UnixMachine/'+serverMachine)
  create(serverMachine,'NodeManager')
  cd('NodeManager/'+serverMachine)
  set('ListenAddress',serverAddress)
#
# Add server to  Unix Machine
def addServerToMachine(serverName, serverMachine):
  print('\nAdd server '+serverName+' to '+serverMachine)
  print (lineSeperator)
  cd('/Servers/'+serverName)
  set('Machine',serverMachine)
#
# Determine the Server Java Args
def getServerJavaArgs(serverName,javaArgsBase,logsHome):
  javaArgs = javaArgsBase+' -Dweblogic.Stdout='+logsHome+'/'+serverName+'.out -Dweblogic.Stderr='+logsHome+'/'+serverName+'_err.out'
  return javaArgs
#
# Change Managed Server
def changeManagedServer(server,listenAddress,listenPort,javaArgs):
  print '\nChange ManagedServer '+server
  print (lineSeperator)
  cd('/Servers/'+server)
  print '. Set listen address and port to: '+listenAddress+':'+str(listenPort)
  set('ListenAddress',listenAddress)
  set('ListenPort'   ,int(listenPort))
  # ServerStart
  print ('. Create ServerStart')
  create(server,'ServerStart')
  cd('ServerStart/'+server)
  print ('. Set Arguments to: '+javaArgs)
  set('Arguments' , javaArgs)
  # SSL
  cd('/Server/'+server)
  print ('. Create server SSL')
  create(server,'SSL')
  cd('SSL/'+server)
  print ('. Set SSL Enabled to: '+'False')
  set('Enabled'                    , 'False')
  print ('. Set SSL HostNameVerificationIgnored to: '+'True')
  set('HostNameVerificationIgnored', 'True')
  #
  if jsseEnabled == 'true':
    print ('. Set JSSEEnabled to: '+ 'True')
    set('JSSEEnabled','True')
  else:
    print ('. Set JSSEEnabled to: '+ 'False')
    set('JSSEEnabled','False')
#
# Create a Managed Server
def createManagedServer(server,listenAddress,listenPort,cluster,machine,
                        javaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan):
  print('\nCreate '+server)
  print (lineSeperator)
  cd('/')
  create(server, 'Server')
  cd('/Servers/'+server)
  javaArgs=getServerJavaArgs(server,javaArgsBase,logsHome)
  changeManagedServer(server,listenAddress,listenPort,javaArgs)
  createServerLog(server, logsHome+'/'+server+'.log', fileCount, fileMinSize, rotationType, fileTimeSpan)
  print('Add '+server+' to cluster '+cluster)
  cd('/')
  assign('Server',server,'Cluster',cluster)
  addServerToMachine(server, machine)
#
# Adapt a Managed Server
def adaptManagedServer(server,newSrvName,listenAddress,listenPort,cluster,machine,
                       javaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan):
  print('\nAdapt '+server)
  print (lineSeperator)
  cd('/')
  cd('/Servers/'+server)
  # name of adminserver
  print '. Rename '+server+' to '+ newSrvName
  set('Name',newSrvName )
  cd('/Servers/'+newSrvName)
  javaArgs=getServerJavaArgs(newSrvName,javaArgsBase,logsHome)
  changeManagedServer(newSrvName,listenAddress,listenPort,javaArgs)
  createServerLog(newSrvName, logsHome+'/'+newSrvName+'.log', fileCount, fileMinSize, rotationType, fileTimeSpan)
  print('Add '+newSrvName+' to cluster '+cluster)
  cd('/')
  assign('Server',newSrvName,'Cluster',cluster)
  addServerToMachine(newSrvName, machine)
#
# Change Admin Server
def changeAdminServer(adminServerName,listenAddress,listenPort,javaArguments):
  print '\nChange AdminServer'
  print (lineSeperator)
  cd('/Servers/AdminServer')
  # name of adminserver
  print '. Set Name to '+ adminServerName
  set('Name',adminServerName )
  cd('/Servers/'+adminServerName)
  # address and port
  print '. Set ListenAddress to '+ server1Address
  set('ListenAddress',server1Address)
  print '. Set ListenPort to '+ str(listenPort)
  set('ListenPort'   ,int(listenPort))
  #
  # ServerStart
  print 'Create ServerStart'
  create(adminServerName,'ServerStart')
  cd('ServerStart/'+adminServerName)
  print '. Set Arguments to: '+javaArguments
  set('Arguments' , javaArguments)
  # SSL
  cd('/Server/'+adminServerName)
  print 'Create SSL'
  create(adminServerName,'SSL')
  cd('SSL/'+adminServerName)
  set('Enabled'                    , 'False')
  set('HostNameVerificationIgnored', 'True')
  #
  if jsseEnabled == 'true':
    print ('. Set JSSEEnabled to: '+ 'True')
    set('JSSEEnabled','True')
  else:
    print ('. Set JSSEEnabled to: '+ 'False')
    set('JSSEEnabled','False')
#
#
def main():
  try:
    #
    # Section 1: Base Domain + Admin Server
    print (lineSeperator)
    print ('1. Create Base domain '+soaDomainName)
    print('\nCreate base wls domain with template '+wlsjar)
    print (lineSeperator)
    readTemplate(wlsjar)
    #
    cd('/')
    # Domain Log
    print('Set base_domain log')
    create('base_domain','Log')
    setLogProperties('/Log/base_domain', logsHome+soaDomainName+'.log', fileCount, fileMinSize, rotationType, fileTimeSpan)    
    #
    # Admin Server
    adminJavaArgs = getServerJavaArgs(adminServerName,adminJavaArgsBase,logsHome)
    changeAdminServer(adminServerName,adminListenAddress,adminListenPort,adminJavaArgs)
    createServerLog(adminServerName, logsHome+adminServerName+'.log', fileCount, fileMinSize, rotationType, fileTimeSpan)   
    #
    print('\nSet password in '+'/Security/base_domain/User/weblogic')
    cd('/')
    cd('Security/base_domain/User/weblogic')
    # weblogic user name + password
    print('. Set Name to: ' +adminUser)
    set('Name',adminUser)
    cmo.setPassword(adminPwd)
    #
    if productionMode == 'true':
      print('. Set ServerStartMode to: ' +'prod')
      setOption('ServerStartMode', 'prod')
    else:
      print('. Set ServerStartMode to: ' +'dev')
      setOption('ServerStartMode', 'dev')
    #
    print('write Domain...')
    # write path + domain name
    writeDomain(soaDomainHome)
    closeTemplate()
    #
    createAdminStartupPropertiesFile(soaDomainHome+'/servers/'+adminServerName+'/data/nodemanager',adminJavaArgs)
    createBootPropertiesFile(soaDomainHome+'/servers/'+adminServerName+'/security','boot.properties',adminUser,adminPwd)
    createBootPropertiesFile(soaDomainHome+'/config/nodemanager','nm_password.properties',adminUser,adminPwd)
    #
    es = encrypt(adminPwd,soaDomainHome)
    #
    readDomain(soaDomainHome)
    #
    print('set Domain password for '+soaDomainName) 
    cd('/SecurityConfiguration/'+soaDomainName)
    set('CredentialEncrypted',es)
    #
    print('Set nodemanager password')
    set('NodeManagerUsername'         ,adminUser )
    set('NodeManagerPasswordEncrypted',es )
    #
    cd('/')
    setOption( "AppDir", soaApplicationsHome )
    #
    print('Finished base domain.')
    #
    # Section 2: Templates
    print('\n2. Extend Base domain with templates.')
    print (lineSeperator)
    print ('Adding Webservice template '+wlservicetpl)
    addTemplate(wlservicetpl)
    # OSB
    if osbEnabled == 'true':
      print ('Adding OSB template '+osbtpl)
      addTemplate(osbtpl)
    else:
      print('OSB is disabled')
    # SOA Suite
    if soaEnabled == 'true':
      print ('Adding SOA Template '+soatpl)    
      addTemplate(soatpl)
    else:
      print('SOA is disabled')
    # BPM
    if bpmEnabled == 'true':
      print ('Adding BPM Template '+bpmtpl)
      addTemplate(bpmtpl)
    else:
      print('BPM is disabled')
    #
    print ('Adding ApplCore Template '+applCoreTpl)
    addTemplate(applCoreTpl)
    #
    if bamEnabled == 'true':
      print ('Adding BAM Template '+bamtpl)
      addTemplate(bamtpl)
    else:
      print ('BAM is disabled')
    #
    if webtierEnabled == 'true' == true:
      print ('Adding OHS Template '+ohsTpl)
      addTemplate(ohsTpl)
    else:
      print('OHS is disabled') 
    #      
    if b2bEnabled == 'true':
      print 'Adding B2B Template '+b2bTpl
      addTemplate(b2bTpl)
    else:
      print('B2B is disabled')
    # 
    dumpStack()
    print ('Finished templates')
    #
    # Section 3: Change Datasources
    print ('\n3. Change datasources')
    print 'Change datasource LocalScvTblDataSource'
    cd('/JDBCSystemResource/LocalSvcTblDataSource/JdbcResource/LocalSvcTblDataSource/JDBCDriverParams/NO_NAME_0')
    set('URL',soaRepositoryDbUrl)
    set('PasswordEncrypted',soaRepositoryStbPwd)
    cd('Properties/NO_NAME_0/Property/user')
    set('Value',soaRepositoryDbUserPrefix+'_STB')
    #
    print ('Call getDatabaseDefaults which reads the service table')
    getDatabaseDefaults()    
    #
    if soaEnabled == 'true':
      changeDatasourceToXA('EDNDataSource')
    if osbEnabled == 'true':
      changeDatasourceToXA('wlsbjmsrpDataSource')
    changeDatasourceToXA('OraSDPMDataSource')
    changeDatasourceToXA('SOADataSource')
    #
    if bamEnabled == 'true':
      changeDatasourceToXA('BamDataSource')
    #
    print 'Finished DataSources'
    #
    # Section 4: Create UnixMachines, Clusters and Managed Servers
    print ('\n4. Create UnixMachines, Clusters and Managed Servers')
    print (lineSeperator)
    cd('/')
    #
    createUnixMachine(server1Machine,server1Address)
    if server2Enabled == 'true':
      createUnixMachine(server2Machine,server2Address)
    #
    addServerToMachine(adminServerName,server1Machine)
    #
    cd('/')
	  # SOA Suite
    if soaEnabled == 'true':
      createCluster(soaClr)
      adaptManagedServer('soa_server1',soaSvr1,server1Address, soaSvr1Port,soaClr,server1Machine,
                         soaJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      if soaSvr2Enabled == 'true':                   
        createManagedServer(soaSvr2,server2Address,soaSvr2Port,soaClr,server2Machine,
                            soaJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      else:
        print('Do not create SOA Server2')
    #
	  # OSB
    if osbEnabled == 'true':
      createCluster(osbClr)
      adaptManagedServer('osb_server1',osbSvr1,server1Address,osbSvr1Port,osbClr,server1Machine,
                         osbJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      if osbSvr2Enabled == 'true':                   
        createManagedServer(osbSvr2,server2Address,osbSvr2Port,osbClr,server2Machine,
                            osbJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      else:
        print('Do not create OSB Server2')  
    # WSM
    if wsmEnabled == 'true':
      createCluster(wsmClr)
      createManagedServer(wsmSvr1,server1Address,wsmSvr1Port,wsmClr,server1Machine,
                          wsmJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      if wsmSvr2Enabled == 'true':                   
        createManagedServer(wsmSvr2,server2Address,wsmSvr2Port,wsmClr,server2Machine,
                            wsmJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      else:
        print('Do not create WSM Server2')
    #
	  # BAM
    if bamEnabled == 'true':
      createCluster(bamClr)
      createManagedServer(bamSvr1,server1Address,bamSvr1Port,bamClr,server1Machine,
                         bamJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      if bamSvr2Enabled == 'true':                   
        createManagedServer(bamSvr2,server2Address,bamSvr2Port,bamClr,server2Machine,
                            bamJavaArgsBase,fileCount,fileMinSize,rotationType,fileTimeSpan)
      else:
        print('Do not create BAM Server2')

    #
    print ('Finshed creating Machines, Clusters and ManagedServers')
    #
    # Section 5: Add Servers to ServerGroups.
    print ('\n5. Add Servers to ServerGroups')
    print (lineSeperator)
    cd('/')
    print 'Add server groups '+adminSvrGrpDesc+ ' to '+adminServerName
    setServerGroups(adminServerName, adminSvrGrp)     
    # WSM
    if wsmEnabled == 'true':
      print 'Add server group '+wsmSvrGrpDesc+' to '+wsmSvr1+' and possibly '+wsmSvr2
      setServerGroups(wsmSvr1, wsmSvrGrp)
      if wsmSvr2Enabled == 'true': 
        setServerGroups(wsmSvr2, wsmSvrGrp)
    # SOA
    if soaEnabled == 'true':
      print 'Add server group '+soaSvrGrpDesc+' to '+soaSvr1+' and possibly '+soaSvr2
      setServerGroups(soaSvr1, soaSvrGrp)
      if soaSvr2Enabled == 'true': 
        setServerGroups(soaSvr2, soaSvrGrp)
    #      
    # OSB
    if osbEnabled == 'true':
      print 'Add server group '+osbSvrGrpDesc+' to '+osbSvr1+' and possibly '+osbSvr2
      setServerGroups(osbSvr1, osbSvrGrp)
      if osbSvr2Enabled == 'true': 
        setServerGroups(osbSvr2, osbSvrGrp)
    #
    if bamEnabled == 'true':
      print 'Add server group '+bamSvrGrpDesc+' to '+bamSvr1+' and possibly '+bamSvr2
      setServerGroups(bamSvr1, bamSvrGrp)
      if bamSvr2Enabled == 'true': 
        setServerGroups(bamSvr2, bamSvrGrp)    
    #
    print ('Finshed ServerGroups.')
    #
    updateDomain()
    closeDomain();
    #
    # Section 6: Create boot properties files.
    print ('\n6. Create boot properties files')
    print (lineSeperator)
    # WSM
    if wsmEnabled == 'true':
      createBootPropertiesFile(soaDomainHome+'/servers/'+wsmSvr1+'/security','boot.properties',adminUser,adminPwd)
      if wsmSvr2Enabled == 'true': 
        createBootPropertiesFile(soaDomainHome+'/servers/'+wsmSvr2+'/security','boot.properties',adminUser,adminPwd)
    # SOA
    if soaEnabled == 'true':
      createBootPropertiesFile(soaDomainHome+'/servers/'+soaSvr1+'/security','boot.properties',adminUser,adminPwd)
      if soaSvr2Enabled == 'true': 
        createBootPropertiesFile(soaDomainHome+'/servers/'+soaSvr2+'/security','boot.properties',adminUser,adminPwd)
    #
    # OSB
    if osbEnabled == 'true':
      createBootPropertiesFile(soaDomainHome+'/servers/'+osbSvr1+'/security','boot.properties',adminUser,adminPwd)
      if osbSvr2Enabled == 'true': 
        createBootPropertiesFile(soaDomainHome+'/servers/'+osbSvr2+'/security','boot.properties',adminUser,adminPwd)
    #
    if bamEnabled == 'true':
      createBootPropertiesFile(soaDomainHome+'/servers/'+bamSvr1+'/security','boot.properties',adminUser,adminPwd)
      if bamSvr2Enabled == 'true': 
        createBootPropertiesFile(soaDomainHome+'/servers/'+bamSvr1+'/security','boot.properties',adminUser,adminPwd)
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