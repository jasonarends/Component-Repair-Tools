@ECHO OFF
color 0f
echo Ending Lacerte Processes in the Background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM w10tax.exe
TASKKILL /F /IM w09tax.exe
TASKKILL /F /IM w08tax.exe
TASKKILL /F /IM w07tax.exe
TASKKILL /F /IM w06tax.exe
TASKKILL /F /IM w05tax.exe
TASKKILL /F /IM msiexec.exe
Echo Unregistering MSXML4 and MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
echo Reregistering MSXML4 and MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
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
echo Repairing C++ 2005...
PING -n 3 127.0.0.1 >NUL
call vcredist.msi /passive
echo Repairing C++ 2008...
PING -n 3 127.0.0.1 >NUL
call vc_red.msi /passive
PING -n 3 127.0.0.1 >NUL
echo Repairing Java Runtime Components...
msiexec /fa JRESetup.msi /passive
PING -n 3 127.0.0.1 >NUL
echo Repairing ProLine Tax Import Components...
msiexec /fa SAPSetup.msi /passive
PING -n 3 127.0.0.1 >NUL
echo Repairing Microsoft .NET 3.5 (this may take a few minutes)...
call dotnetfx35.exe /f /norestart
echo Running .NET Checker (Make sure to select .NET 3.5 to Verify...
PING -n 7 127.0.0.1 >NUL
call netfx_setupverifier.exe