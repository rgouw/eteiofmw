@echo off
rem Part 1: Settings
set JAVA_HOME=c:\Program Files\Java\jdk1.8.0_112
set JAVA_INSTALLER=jdk-8u112-windows-x64.exe
set FMW_HOME=C:\oracle\JDeveloper\12212_BPMQS2
set QS_RSP=bpmqs1221_silentInstall.rsp
set QS_RSP_TPL=%QS_RSP%.tpl
set QS_JAR=fmw_12.2.1.2.0_bpm_quickstart.jar
set QS_ZIP=fmw_12.2.1.2.0_bpmqs_Disk1_1of2.zip
set QS_JAR2=fmw_12.2.1.2.0_bpm_quickstart2.jar
set QS_ZIP2=fmw_12.2.1.2.0_bpmqs_Disk1_2of2.zip
rem Part 2: Install Java
rem Set JAVA_HOME
echo setx -m JAVA_HOME "%JAVA_HOME%"
setx -m JAVA_HOME "%JAVA_HOME%"
echo JAVA_HOME=%JAVA_HOME%
rem Check Java
if exist "%JAVA_HOME%" goto :JAVA_HOME_EXISTS
if exist "%JAVA_INSTALLER%" goto :JAVA_INSTALLER_EXISTS
echo Java Installer %JAVA_INSTALLER% does not exist.
goto :DONE_NOT_INSTALLED
:JAVA_INSTALLER_EXISTS
echo Install %JAVA_HOME% 
%JAVA_INSTALLER% /s INSTALLDIR="%JAVA_HOME%"
if exist "%JAVA_HOME%" goto :JAVA_HOME_EXISTS
echo Java Installer %JAVA_INSTALLER% apparently failed.
goto :DONE_NOT_INSTALLED
:JAVA_HOME_EXISTS
echo JAVA_HOME %JAVA_HOME% exists
rem Part 3: Check the QuickStart Installer Files
rem check BPM12.2 QS
if exist "%FMW_HOME%" goto :BPMQS_HOME_EXISTS
rem Check Quickstart is unzipped
echo "Check if QuickStart is unzipped"
rem Check QS_JAR
if exist "%QS_JAR%" goto :QS_JAR_EXISTS
if exist "%QS_ZIP%" goto :QS_ZIP_EXISTS
echo QuickStart ZIP part 1 %QS_ZIP% does not exist.
goto :DONE_NOT_INSTALLED
:QS_ZIP_EXISTS
echo Unzip QuickStart Part 1 %QS_ZIP%
"%JAVA_HOME%"\bin\jar.exe -xf %QS_ZIP%
if exist "%QS_JAR%" goto :QS_JAR_EXISTS
echo QuickStart Jar part 1 %QS_JAR% still not exists.
goto :DONE_NOT_INSTALLED
:QS_JAR_EXISTS
echo QuickStart Jar part 1 %QS_JAR% exists.
rem Check QS_JAR2
if exist "%QS_JAR2%" goto :QS_JAR2_EXISTS
if exist "%QS_ZIP2%" goto :QS_ZIP2_EXISTS
echo  QuickStart ZIP part 2, %QS_ZIP2% does not exist.
goto :DONE_NOT_INSTALLED
:QS_ZIP2_EXISTS
echo Unzip QuickStart Part 2 %QS_ZIP2%
"%JAVA_HOME%"\bin\jar.exe -xf %QS_ZIP2%
if exist "%QS_JAR2%" goto :QS_JAR2_EXISTS
echo QuickStart Jar Part 2 %QS_JAR2% still not exists.
goto :DONE_NOT_INSTALLED
:QS_JAR2_EXISTS
echo QuickStart Jar Part 2 %QS_JAR2% exists.
rem Part 4: Install the QuickStart
echo Install %FMW_HOME% 
rem echo "Current dir2:" %~dp0
echo Expand Response File Template  %QS_RSP_TPL% to %QS_RSP%
powershell -Command "(Get-Content %cd%\%QS_RSP_TPL%) -replace '\$\{ORACLE_HOME\}', '%FMW_HOME%' | Out-File -encoding ASCII %cd%\%QS_RSP%"
echo Check if QuickStart is unzipped
echo Silent install BPM QuickStart, using response file: %cd%\%QS_RSP%
"%JAVA_HOME%\bin\java.exe" -jar %QS_JAR% -silent -responseFile %cd%\%QS_RSP% -nowait
if exist "%FMW_HOME%" goto :BPMQS_HOME_EXISTS
echo Quickstart Installer %QS_JAR% apparently failed.
goto :DONE_NOT_INSTALLED
:BPMQS_HOME_EXISTS
echo FMW_HOME %FMW_HOME% exists
rem Part 5: update the JDeveloper User Home location.
echo "Set the JDeveloper user home settings"
if not exist c:\Data mkdir c:\Data
if not exist c:\Data\JDeveloper mkdir c:\Data\JDeveloper
if not exist c:\Data\JDeveloper\SOA mkdir c:\Data\JDeveloper\SOA
rem set  JDEV_USER_DIR_SOA and JDEV_USER_HOME_SOA as 'c:\Data\JDeveloper\SOA'
echo set  JDEV_USER_DIR_SOA and JDEV_USER_HOME_SOA as c:\Data\JDeveloper\SOA
setx -m JDEV_USER_DIR_SOA c:\Data\JDeveloper\SOA
setx -m JDEV_USER_HOME_SOA c:\Data\JDeveloper\SOA
echo copy jdev.boot naar "%FMW_HOME%\jdeveloper\jdev\bin"
copy "%FMW_HOME%\jdeveloper\jdev\bin\jdev.boot" "%FMW_HOME%\jdeveloper\jdev\bin\jdev.boot.org" /Y
copy jdev.boot "%FMW_HOME%\jdeveloper\jdev\bin" /Y
goto :DONE
:DONE_NOT_INSTALLED
echo QuickStart is not installed!
:DONE
echo Done