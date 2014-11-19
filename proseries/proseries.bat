@ECHO OFF
color 9f
echo Ending ProSeries Processes in the Background...
PING -n 3 127.0.0.1 >NUL
for /f "tokens=1" %%i in ('tasklist /nh /fi "imagename eq protax*"') do echo %%i | find ".exe" && taskkill /f /fi "imagename eq %%i"

TASKKILL /F /IM msiexec.exe

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

echo Repairing C++ 2005...
PING -n 3 127.0.0.1 >NUL
start /wait vcredist05_x86.exe /Q

echo Repairing C++ 2008...
PING -n 3 127.0.0.1 >NUL
start /wait vcredist08_x86.exe /q

echo Repairing C++ 2010...
PING -n 3 127.0.0.1 >NUL
start /wait vcredist10_x86.exe /passive /norestart /repair

echo Repairing C++ 2012...
PING -n 3 127.0.0.1 >NUL
start /wait vcredist12_x86.exe /passive /norestart /repair

echo Repairing Microsoft .NET 3.5 (this may take a few minutes)...
echo *** A message about enabling .NET 3.5 via the control panel is normal ***
start /wait dotnetfx35.exe /f /norestart

echo Repairing Microsoft .NET 4.5 (this may take a few minutes)...
start /wait dotNetFx45_Full_setup.exe /repair /passive /norestart

echo Running .NET Checker (Make sure to manually verify .NET 3.5 and 4.5.1...
PING -n 3 127.0.0.1 >NUL
start /wait netfx_setupverifier.exe

echo Repairing Intuit Entitlement Components...
start /wait msiexec /fa EntlClnt.msi

echo *** A reboot is recommended at this time ***
pause