#!/bin/bash
echo _______________________________________________________________________________
echo Installing Oracle Database 12c
./installDB.sh
echo _______________________________________________________________________________
echo Java SDK 8
./installJava.sh
echo
echo _______________________________________________________________________________
echo Fusion Middleware Infrastructure
./installFMW.sh
echo
echo _______________________________________________________________________________
echo SOA & BPM Suite
./installSOA.sh
echo
echo _______________________________________________________________________________
echo ServiceBus
./installSB.sh
echo
echo _______________________________________________________________________________
echo WebCenter Content
./installWCC.sh
echo
echo _______________________________________________________________________________
echo WebCenter Portal
./installWCP.sh
echo
echo _______________________________________________________________________________
echo WebCenter Portal
./installOHS.sh
echo
echo _______________________________________________________________________________
echo JDeveloper WebCenter
./installJDevWC.sh
