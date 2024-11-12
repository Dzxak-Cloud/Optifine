@echo off
setlocal enabledelayedexpansion
color 0A

set "mod_folder=%APPDATA%\.minecraft"

:: Link to the mods.zip file
set "mods_zip_url=https://download1324.mediafire.com/cwuk8dnfhtqg-3Mzw3wuqaJhDiZCd0IT2YgDLWswsMuZN32YJinksbLcmDf4O2B_y4dIHzv5fhoDPW_77b-HDvALGySTiTAuxpoSM7HQtCR0iXmvo9jUC4jNgM4cF6KUFecRXQsfM_rWib5fyvudypPaqHlOb7r8x4RdV03gu0WXPpk/3a0yroky0w7ixdt/mods.zip"
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
