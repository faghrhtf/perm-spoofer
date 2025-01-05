@echo off

echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as admin..
    pause
    exit /b
)

echo AMIDEWIN Spoofing..

for /f "delims=" %%i in ('call randstr.bat 10') do set "output9=%%i"
for /f "delims=" %%i in ('call randstr.bat 14') do set "output91=%%i"
for /f "delims=" %%i in ('call randstr.bat 10') do set "output92=%%i"

set currentDir=%~dp0
cd "%currentDir%AMI"

AMIDEWINx64.EXE /IVN "AMI"
AMIDEWINx64.EXE /SM "System manufacturer"
AMIDEWINx64.EXE /SP "System product name"
AMIDEWINx64.EXE /SV "System version"
AMIDEWINx64.EXE /SS %output9%
AMIDEWINx64.EXE /SU AUTO
AMIDEWINx64.EXE /SK "To Be Filled By O.E.M"
AMIDEWINx64.EXE /SF "To Be Filled By O.E.M."
AMIDEWINx64.EXE /BM "ASRock"
AMIDEWINx64.EXE /BP "B560M-C"
AMIDEWINx64.EXE /BV " "
AMIDEWINx64.EXE /BS %output91%
AMIDEWINx64.EXE /BT "Default string"
AMIDEWINx64.EXE /BLC "Default string"
AMIDEWINx64.EXE /CM "Default string"
AMIDEWINx64.EXE /CV "Default string"
AMIDEWINx64.EXE /CS %output92%
AMIDEWINx64.EXE /CA "Default string"
AMIDEWINx64.EXE /CSK "SKU"
AMIDEWINx64.EXE /PSN "To Be Filled By O.E.M."
AMIDEWINx64.EXE /PAT "To Be Filled By O.E.M."
AMIDEWINx64.EXE /PPN "To Be Filled By O.E.M."

echo AMIDEWIN Spoofed!

echo AFUWIN Spoofing..
cd "%currentDir%"
AFUWINx64.exe BIOS.rom /o
AFUWINx64.exe BIOS.rom /p
echo AFUWIN Spoofed!

:: Add the new menu for IP and MAC Spoofing
:IP_MAC_SPOOFING
cls

echo.
echo [97m[1] Perform IP and MAC Spoofing
echo [2] Return to Main Menu
echo [0m

set /p choice=Choose an option:

if "%choice%"=="1" goto DO_IP_MAC_SPOOF
if "%choice%"=="2" goto MENU

echo Invalid choice. Please select either [1] or [2].
pause
goto IP_MAC_SPOOFING

:DO_IP_MAC_SPOOF
cls
echo Performing IP and MAC Spoofing...

:: Volume ID Spoofing
echo Volumeid Spoofing..

cd "%currentDir%"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output3=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output31=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output32=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output33=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output34=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output35=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output36=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output37=%%i"
cd "%currentDir%VOLUME"

Volumeid64.exe C: %output3%-%output31% /accepteula
Volumeid64.exe D: %output32%-%output33% /accepteula
Volumeid64.exe E: %output34%-%output35% /accepteula
Volumeid64.exe F: %output36%-%output37% /accepteula

echo Volumeid Spoofed!
echo MAC Spoofing..

cd "%currentDir%NETWORK"
call MAC.bat

echo MAC Spoofed!
echo Doing network reset...

:: Network reset commands
netsh winsock reset
netsh winsock reset catalog
netsh int ip reset
netsh advfirewall reset
netsh int reset all
netsh int ipv4 reset
netsh int ipv6 reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ipconfig /flushdns
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL DISABLE >nul 2>&1
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL ENABLE >nul 2>&1
ipconfig /arp -d
net stop winmgmt /y
net start winmgmt

echo Network reset complete!
pause
goto MENU
