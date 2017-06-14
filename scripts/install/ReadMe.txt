Hostname
_____________
De hostname van de VM heeft de briljante naam van 10.0.2.15 .
Dit gaat bij het connecteren aan de database maar zeker ook met wls problemen geven. 
Ik stel iets voor als 'darlin-vce-book' (is een linux 'Virtual Course Environment' tbv. van ons boek). Ik heb het bij mij nu aangepast met:
$ sysctl kernel.hostname=darlin-vce-book

Zie deze blog: http://www.ducea.com/2006/08/07/how-to-change-the-hostname-of-a-linux-system/

Database
__________
In de listener.ora en tnsnames.ora moet de 'dbhost' aangepast worden in de gezette hostname van Linux.

In de db12c_env.sh staat het volgende:
export ORACLE_SID=book
export DB_CONNECT_STR=darlin-vce-book:1521:${ORACLE_SID}

Dit is nodig voor het draaien van de RCU: in de rsp wordt de database connect string vervangen door de waarde van DB_CONNECT_STR.


OHS
__________
Uit thread: https://community.oracle.com/thread/3980791

Supposing all of the above questions are yes, then:

1. Examine this part of the OHS documentation - https://docs.oracle.com/middleware/1213/core/ASHIA/webtier.htm#ASHIA4406

2. Actually you can configure OHS to reverse proxy all requests to the soa infra  by setting:

<Location /soa-infra>

SetHandler weblogic-handler

WebLogicCluster apphost1.example.com:7050,apphost2.example.com:7050

WLProxySSL On

WLProxySSLPassThrough ON

DefaultFileName index.jsp

</Location>