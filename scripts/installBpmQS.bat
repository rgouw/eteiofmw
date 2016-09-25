@echo off
set JAVA_HOME=c:\Program Files\Java\jdk1.8.0_92
echo setx -m JAVA_HOME "%JAVA_HOME%"
setx -m JAVA_HOME "%JAVA_HOME%"
echo JAVA_HOME=%JAVA_HOME%
rem Check Java
if exist "%JAVA_HOME%" goto :JAVA_HOME_EXISTS
echo Install %JAVA_HOME% 
jdk-8u92-windows-x64.exe /s INSTALLDIR="%JAVA_HOME%"
:JAVA_HOME_EXISTS
echo %JAVA_HOME% exists
rem check BPM12.2 QS
set FMW_HOME=C:\oracle\JDeveloper\12210_BPMQS
if exist "%FMW_HOME%" goto :BPMQS_HOME_EXISTS
echo Install %FMW_HOME% 
rem echo "Current dir2:" %~dp0
echo "Silent install BPM QuickStart, using response file:" %cd%\bpmqs1221_silentInstall.rsp
"%JAVA_HOME%\bin\java.exe" -jar fmw_12.2.1.0.0_bpm_quickstart.jar -silent -responseFile %cd%\bpmqs1221_silentInstall.rsp -nowait
:BPMQS_HOME_EXISTS
echo %FMW_HOME% exists
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
echo done