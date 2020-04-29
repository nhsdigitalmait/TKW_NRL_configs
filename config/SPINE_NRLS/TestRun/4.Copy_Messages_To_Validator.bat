@title NRLS Copy Files And Prepare For Validation

@echo off

rem Copy messages to validate here

@echo copying simulator_saved_messages to messages_for_validation folder ....


del ..\validator_reports\*.* /q >nul
del ..\messages_for_validation\*.* /q >nul


for %%f in (..\simulator_saved_messages\*.log) do (
	copy %%f ..\messages_for_validation\*.log >nul )

@echo copying simulator_saved_messages to messages_for_validation now completed....
@



@echo insert correct "Validate as....." text at start of message....

for %%f in (..\messages_for_validation\*.log) do (
	copy %%f ..\messages_for_validation\message.cpy >nul
	
	findstr /c:"DELETE" ..\messages_for_validation\message.cpy>temp1.txt
	for %%a in (temp1.txt) do if %%~za GTR 2 (
	copy ..\TestRun\Validate_As_SimulatorLogRequest_Delete.txt+..\messages_for_validation\message.cpy %%f /B >nul
	)
	
	findstr /c:"GET" ..\messages_for_validation\message.cpy>temp1.txt
	for %%a in (temp1.txt) do if %%~za GTR 2 (
	copy ..\TestRun\Validate_As_SimulatorLogRequest_Search.txt+..\messages_for_validation\message.cpy %%f /B >nul
	)
	
	findstr /c:"POST" ..\messages_for_validation\message.cpy>temp1.txt
	for %%a in (temp1.txt) do if %%~za GTR 2 (
	copy ..\TestRun\Validate_As_SimulatorLogRequest_Create.txt+..\messages_for_validation\message.cpy %%f /B >nul
	)
	
	del ..\messages_for_validation\message.cpy >nul
	del temp1.txt
)

@
@echo inserting "Validate as....." completed....
@
@echo messages ready to validate....
@echo ....
pause

rem Validate Messages here 

rem echo validate messages starting....
rem @echo ....
rem java -jar ..\..\..\TKW.jar -validate ..\tkw.properties

rem @echo ....
rem @echo validate messages completed....
rem @echo ....
rem pause



