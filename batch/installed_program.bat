@echo off
REM Reference: http://www.techrepublic.com/forum/questions/101-215911/dos-command-to-list-all-installed-programs
set host=%COMPUTERNAME%
set fn=software_list_%host%.txt
echo ================= >>%fn%
reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall temp1.txt
find "DisplayName" temp1.txt| find /V "ParentDisplayName" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo %%a >> %fn%)
del temp1.txt
del temp2.txt
REM type %fn% | more
echo.
echo.
echo Installed software are stored in %fn%
