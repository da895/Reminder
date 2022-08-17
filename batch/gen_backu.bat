@ECHO¡¡OFF

SETLOCAL

SET me=%~n0
SET parent=%~dp0
SET me_log=%parent%%me%.log
SET back_log=%parent%backup.log
SET restore_log=%parent%restore.log
SET BACK_BAT=%parent%backup.bat
SET BACK_VBS=%parent%backup.vbs

IF EXIST %me_log% DEL /Q %me_log% > NUL
IF EXIST %BACK_BAT% DEL /Q %BACK_BAT% > NUL
IF EXIST %BACK_VBS% DEL /Q %BACK_VBS% > NUL

SET _SRC=D:\
SET _DST=\\10.6.6.79\otc_asic\Group\ASIC_Verfication\Public\backup\1993

:: ROBOCOPY OPTION
SET _what=/E /COPY:DATO /J
SET _opt_bak=/R:1 /W:1 /LOG+:%back_log% /TS /FP /NP /NDL /NJH /TIMFIX 
SET _opt_restore=/R:1 /W:1 /LOG+:%restore_log% /TS /FP /NP /NDL /NJH /TIMFIX

:: SCHTASK OPTION
SET _bak_TN=backup_public79

CALL :PRINT_BACK_BAT %BACK_BAT%
:: CALL :PRINT_BACK_VBS %BACK_VBS%
IF EXIST %BACK_BAT% (
	echo SUCCESSFUL to generate %BACK_BAT% >> %me_log%
) else (
	echo Fail to generate %BACK_BAT%, abort! >> %me_log%
        goto :END
) 

IF EXIST %BACK_VBS% (
	echo SUCCESSFUL to generate %BACK_VBS% >> %me_log%
) else (
	echo Fail to generate %BACK_VBS%, abort! >> %me_log%
        goto :END
) 

::SCHTASKS /Create /TN %_bak_TN% /TR %BACK_VBS%  /ST 05:30 /ET 23:59  /SC minute /F  /MO 10 /K
SCHTASKS /Create /TN %_bak_TN% /TR %BACK_VBS%  /SC minute /F  /MO 10 /K

SCHTASKS /QUERY /TN %_bak_TN% > NUL
IF %ERRORLEVEL% EQU 0 (
	echo Successfully to Create Schedule Task: %_bak_TN%! >> %me_log% 
) else (
	echo Fail to Create Schedule Task: %_bak_TN%! >> %me_log% 
)

goto :END

:PRINT_BACK_BAT
IF "%1." == "." EXIT /B 0
echo. @ECHO OFF >> %1
echo. SETLOCAL  >> %1
echo.  >> %1
echo. IF NOT EXIST %_SRC% goto :RESTORE >> %1
echo.  >> %1
echo. ROBOCOPY %_SRC% %_DST% %_what% %_opt_bak% >> %1
echo.  >> %1
echo. goto :END >> %1
echo.  >> %1
echo. :RESTORE >> %1
echo. ROBOCOPY %_DST% %_SRC% %_what% %_opt_restore% >> %1
echo.  >> %1
echo. :END    >> %1
echo. ENDLOCAL >> %1
echo. ECHO ON  >> %1
echo. @EXIT /B 0 >> %1
EXIT /B 0


:PRINT_BACK_VBS
IF "%1." == "." EXIT /B 0
echo. Set WshShell = CreateObject("WScript.Shell") >>%1
echo. WshShell.Run chr(34) ^& "%BACK_BAT%" ^& Chr(34), 0 >>%1
echo. Set WshShell = Nothing >>%1
EXIT /B 0

:END
ENDLOCAL
ECHO ON
@EXIT /B 0

