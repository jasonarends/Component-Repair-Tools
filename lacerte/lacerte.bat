@ECHO OFF
color 0f
echo Ending Lacerte Processes in the Background...
PING -n 3 127.0.0.1 >NUL
for /f "tokens=1" %%i in ('tasklist /nh /fi "imagename eq w*"') do echo %%i | find "tax.exe" && taskkill /f /fi "imagename eq %%i"

echo Unregistering MSIEXEC...
PING -n 3 127.0.0.1 >NUL
msiexec /unreg

echo Reregistering MSIEXEC...
PING -n 3 127.0.0.1 >NUL
msiexec /regserver

echo Stopping Windows Installer Service...
PING -n 3 127.0.0.1 >NUL
net stop MSIServer

echo Starting Windows Installer Service...
PING -n 3 127.0.0.1 >NUL
net start MSIServer

Echo Unregistering MSXML4 and MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml4.dll

regsvr32 /u /s msxml6.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll

echo Installing MSXML 4.0 SP3...
PING -n 3 127.0.0.1 >NUL

msiexec /fa msxml4sp3.msi /passive 

echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL

regsvr32 /s msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll

echo Repairing Java Runtime Components...
msiexec /fa JRESetup.msi /passive
PING -n 3 127.0.0.1 >NUL

echo Repairing Microsoft .NET 3.5 (this may take a few minutes)...
call dotnetfx35.exe /f /norestart

echo Repairing Microsoft .NET 4.5 (this may take a few minutes)...
call dotNetFx45_Full_setup.exe /repair /passive /norestart

echo Running .NET Checker (Make sure to select .NET 3.5 and 4.5 to Verify...
PING -n 7 127.0.0.1 >NUL
call netfx_setupverifier.exe