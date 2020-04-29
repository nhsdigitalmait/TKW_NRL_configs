@echo off
@echo .
@echo Prior to validation ALL request messages must have first been  prefixed with "VALIDATE-AS: SIMULATOR_LOG_REQUEST"
@echo ..

pause

java -jar ..\..\..\TKW.jar -validate ..\tkw.properties

pause

