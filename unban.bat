@echo off

echo.

:: التحقق من تشغيل السكربت كمسؤول
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo يرجى تشغيل السكربت كمسؤول..
    pause
    exit /b
)

cd /d "%~dp0"

echo AMIDEWIN Spoofing..

for /f "delims=" %%i in ('call randstr.bat 10') do set "output9=%%i"
for /f "delims=" %%i in ('call randstr.bat 14') do set "output91=%%i"
for /f "delims=" %%i in ('call randstr.bat 10') do set "output92=%%i"

cd AMI

:: تغيير إعدادات BIOS باستخدام AMIDEWIN
AMIDEWINx64.EXE /IVN "Custom BIOS"
AMIDEWINx64.EXE /SM "Custom Manufacturer"
AMIDEWINx64.EXE /SP "Custom Product"
AMIDEWINx64.EXE /SV "Custom Version"
AMIDEWINx64.EXE /SS %output9%
AMIDEWINx64.EXE /SU AUTO
AMIDEWINx64.EXE /SK "OEM Custom Data"
AMIDEWINx64.EXE /SF "Custom Field Data"
AMIDEWINx64.EXE /BM "CustomBrand"
AMIDEWINx64.EXE /BP "CustomBoard"
AMIDEWINx64.EXE /BV "Custom BIOS Version"
AMIDEWINx64.EXE /BS %output91%
AMIDEWINx64.EXE /BT "Default string"
AMIDEWINx64.EXE /BLC "Default string"
AMIDEWINx64.EXE /CM "Default string"
AMIDEWINx64.EXE /CV "Default string"
AMIDEWINx64.EXE /CS %output92%
AMIDEWINx64.EXE /CA "Custom Data"
AMIDEWINx64.EXE /CSK "SKU123"
AMIDEWINx64.EXE /PSN "Serial-123456"
AMIDEWINx64.EXE /PAT "Asset-Tag123"
AMIDEWINx64.EXE /PPN "Product-Name123"

echo AMIDEWIN Spoofed!

:: تغيير سيريالات الأقراص
echo Disk Serial Number Spoofing...

cd ..
cd VOLUME

for %%d in (C D E F G H) do (
    for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "volID1=%%i"
    for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "volID2=%%i"
    Volumeid64.exe %%d: %volID1%-%volID2% /accepteula
    echo Serial for drive %%d: changed to %volID1%-%volID2%.
)

echo Disk Serial Numbers Spoofed!

:: تغيير عنوان MAC
echo MAC Spoofing...

cd ..
cd NETWORK
call MAC.bat

echo MAC Spoofed!

:: إعادة ضبط الشبكة
echo Resetting network...

netsh winsock reset
netsh int ip reset
netsh advfirewall reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew

echo Network reset complete!

:: تغيير SID
echo SID Spoofing...

cd ..
cd SID
SIDCHG64.exe /KEY="7rq1f-#RkvE-g#f4O-sJ" /F /R /OD /RESETALLAPPS

echo SID Spoofed!

pause
