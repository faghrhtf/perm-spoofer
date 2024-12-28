@echo off

echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run as admin..
    pause
    exit /b
)

set /p isAsus=Are you on Asus (Yes, No)? 



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


exit
