@echo off
setlocal enabledelayedexpansion

:: التحقق من وجود إدخال طول السلسلة
if "%1"=="" (
    echo Usage: %~nx0 [length] [/v]
    echo Example: %~nx0 10 /v
    goto :eof
)

:: تعيين الطول والمدخلات الأخرى
set "length=%1"
set "exclude_volume=%2"

:: تحديد الأحرف المسموح بها
set "chars=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
if /i "%exclude_volume%"=="/v" (
    set "chars=ABCDEF0123456789"
)

:: التحقق من أن الطول هو رقم صالح
for /f "tokens=* delims=0123456789" %%A in ("%length%") do (
    echo Error: Length must be a number.
    goto :eof
)

:: إنشاء السلسلة العشوائية
set "randomStr="
for /L %%i in (1,1,%length%) do (
    set /a "index=!random! %% %len_chars%"
    set "randomStr=!randomStr!!chars:~!index!,1!"
)

:: عرض النتيجة
echo Random String: !randomStr!

exit /b
