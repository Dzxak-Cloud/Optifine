@echo off
setlocal enabledelayedexpansion
color 0A

set "mod_folder=%APPDATA%\.minecraft"

:: Link to the mods.zip file
set "mods_zip_url="https://doc-10-18-docs.googleusercontent.com/docs/securesc/3prfoc3olk9bnf64f3g7hi4v373725fa/rnj5mpr35eefn2gn82b3322k47aor7d4/1731490950000/01384825447918626680/18058053277852350779Z/1K92uS95ktniQxxgjYTHn4-NCBmBQejUP?e=download&uuid=c380e477-c85f-411e-9fff-f646da0687df"
set "zip_path=%APPDATA%\.minecraft\mods.zip"

cls
echo Mendownload mods.zip...
timeout 3

:: Confirm download
set /p confirm="Mau melanjutkan Download mods.zip ini? (y/n): "
if /i "%confirm%" neq "y" (
    echo Download dibatalkan.
    goto end
)

if not exist "%mod_folder%" mkdir "%mod_folder%"

:: Download mods.zip
powershell -Command "Invoke-WebRequest -Uri '%mods_zip_url%' -OutFile '%zip_path%'"
if errorlevel 1 (
    echo Gagal mendownload mods.zip.
    goto end
)

:: Extract mods.zip to %APPDATA%\.minecraft
echo Mengekstrak mods.zip ke %mod_folder%...
powershell -Command "Expand-Archive -Path '%zip_path%' -DestinationPath '%mod_folder%'"

:: Delete the downloaded mods.zip file after extraction
del "%zip_path%"

echo Mod telah berhasil di-download dan diekstrak.
explorer "%mod_folder%"

:end
:: Menghapus skrip setelah selesai
del "%~f0"
