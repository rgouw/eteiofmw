@echo off
set JAVA_HOME=c:\Program Files\Java\jdk1.8.0_91
echo setx -m JAVA_HOME "%JAVA_HOME%"
setx -m JAVA_HOME "%JAVA_HOME%"
echo JAVA_HOME=%JAVA_HOME%
rem Check Java
if exist "%JAVA_HOME%" goto :JAVA_HOME_EXISTS
echo Install %JAVA_HOME% 
jdk-8u91-windows-x64.exe /s INSTALLDIR="%JAVA_HOME%"
:JAVA_HOME_EXISTS
echo %JAVA_HOME% exists
