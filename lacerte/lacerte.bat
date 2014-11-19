@ECHO OFF
color 9f
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

start /wait msiexec /fa msxml4sp3.msi /passive 

echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL

regsvr32 /s msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll

echo Repairing Java Runtime Components...
start /wait msiexec /f JRESetup.msi /norestart
PING -n 3 127.0.0.1 >NUL

echo Repairing Microsoft WSE 3.0...
start /wait msiexec /fa MicrosoftWSE30Runtime.msi /passive /norestart
PING -n 3 127.0.0.1 >NUL

echo Repairing Microsoft .NET 3.5 (this may take a few minutes)...
echo *** A message about enabling .NET 3.5 via the control panel is normal ***
start /wait dotnetfx35.exe /f /norestart

echo Repairing Microsoft .NET 4.5 (this may take a few minutes)...
start /wait dotNetFx45_Full_setup.exe /repair /passive /norestart

echo Running .NET Checker (Make sure to manually verify .NET 3.5 and 4.5.1...
PING -n 3 127.0.0.1 >NUL
start /wait netfx_setupverifier.exe

echo *** A reboot is recommended at this time ***
pause