@echo off

echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as admin..
    pause
    exit /b
)

set /p isAsus=Are you on Asus (Yes, No)? 

echo.
echo Don't put Yes if you put "Yes" for the question above.
echo Example motherboards: HP, Dell
set /p isLocked=Are you on a locked motherboard? (Yes, No)? 

cd /d "%~dp0"

echo AMIDEWIN Spoofing..

for /f "delims=" %%i in ('call randstr.bat 10') do set "output9=%%i"
for /f "delims=" %%i in ('call randstr.bat 14') do set "output91=%%i"
for /f "delims=" %%i in ('call randstr.bat 10') do set "output92=%%i"

cd AMI

if /i "%isLocked%" == "No" (
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
)

if /i "%isAsus%" == "Yes" (
    echo AFUWIN Spoofing..
    AFUWINx64.exe BIOS.rom /o
    AFUWINx64.exe BIOS.rom /p
    echo AFUWIN Spoofed!
)

if /i "%isLocked%" == "Yes" (
    echo.
    echo Please wait a moment..

    cd USB
    cd efi
    cd boot

    (
    echo echo -off
    echo AMIDEEFIx64.efi /IVN "AMI"
    echo AMIDEEFIx64.efi /SM "System manufacturer"
    echo AMIDEEFIx64.efi /SP "System product name"
    echo AMIDEEFIx64.efi /SV "System version"
    echo AMIDEEFIx64.efi /SS "%output%"
    echo AMIDEEFIx64.efi /SU AUTO
    echo AMIDEEFIx64.efi /SK "To Be Filled By O.E.M"
    echo AMIDEEFIx64.efi /SF "To Be Filled By O.E.M."
    echo AMIDEEFIx64.efi /BM "ASRock"
    echo AMIDEEFIx64.efi /BP "B560M-C"
    echo AMIDEEFIx64.efi /BV " "
    echo AMIDEEFIx64.efi /BS "%output1%"
    echo AMIDEEFIx64.efi /BT "Default string"
    echo AMIDEEFIx64.efi /BLC "Default string"
    echo AMIDEEFIx64.efi /CM "Default string"
    echo AMIDEEFIx64.efi /CV "Default string"
    echo AMIDEEFIx64.efi /CS "%output2%"
    echo AMIDEEFIx64.efi /CA "Default string"
    echo AMIDEEFIx64.efi /CSK "SKU"
    echo AMIDEEFIx64.efi /PSN "To Be Filled By O.E.M."
    echo AMIDEEFIx64.efi /PAT "To Be Filled By O.E.M."
    echo AMIDEEFIx64.efi /PPN "To Be Filled By O.E.M."
    echo exit
    ) > "startup.nsh"

    cd ..
    cd ..
    cd ..

    echo .
    echo All files you need to perm are in AMI\USB.
    echo Go to the USB folder, and copy all files.
    echo Put them on your USB drive, and get rid of all other files.
    pause
)

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

cd ..
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output3=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output31=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output32=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output33=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output34=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output35=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output36=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output37=%%i"
cd VOLUME

Volumeid64.exe C: %output3%-%output31% /accepteula
Volumeid64.exe D: %output32%-%output33% /accepteula
Volumeid64.exe E: %output34%-%output35% /accepteula
Volumeid64.exe F: %output36%-%output37% /accepteula

echo Volumeid Spoofed!
echo MAC Spoofing..

cd ..
cd NETWORK
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
echo SID Spoofing..

cd ..
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "output77=%%i"
cd SID

SIDCHG64.exe /KEY="7rq1f-#RkvE-g#f4O-sJ" /F /R /OD /RESETALLAPPS

echo SID Spoofed!
pause
goto MENU
