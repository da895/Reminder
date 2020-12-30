@echo off

SETLOCAL ENABLEEXTENSIONS

:: Check interactive
SET noninteractive=1
echo %CMDCMDLINE% | FINDSTR /L /B %COMSPEC% >NUL 2>&1
IF %ERRORLEVEL% == 0 SET noninteractive=0

SET me=%~n0
SET parent=%~dp0

SET log=%TEMP%\%me%.txt
IF EXIST %log% DEL /Q %log% >NUL

for /f "delims=" %%a in ('vmic OS Get localdatetime ^| find "."') do SET DateTime=%%a

SET filename=name_%DateTime:~0,8%.txt

SET Today=%DATE%
SET now=%TIME%

:: The "main" logic of the script
::
:: dir /b /od *.sof
:: for /f "tokens=*" %%a in ('dir /b /od *.sof') do set latest=%%a
:: echo latest: "%latest%"  

::IF NOT EXIST  tt.exe ( 
:: echo Can not find tt.exe, Exit
:: goto :END
::)
::
:: Generate MD5
:: CertUtil.exe -hashfile yourfileName MD5

title Reverse RPD File
IF EXIST %~dp0reversed_rpd.bin DEL %~dp0reversed_rpd.bin
%~dp0reverse_rpd.exe %~dp0output_file_auto.rpd

echo ----------->>%log%
:: echo blank line
echo.           >>%log%

:: The End logic of the script
:END
IF "%noninteractive%"=="0" PAUSE
ENDLOCAL
ECHO ON
@EXIT /B 0
