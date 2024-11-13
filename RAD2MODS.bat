@echo off
setlocal enabledelayedexpansion
color 0A

set "mod_folder=%APPDATA%\.minecraft"

:: Link to the mods.zip file
set "mods_zip_url="http://206.189.144.244:8080/api/raw/mods.zip?auth=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJsb2NhbGUiOiJlbiIsInZpZXdNb2RlIjoibGlzdCIsInNpbmdsZUNsaWNrIjpmYWxzZSwicGVybSI6eyJhZG1pbiI6dHJ1ZSwiZXhlY3V0ZSI6dHJ1ZSwiY3JlYXRlIjp0cnVlLCJyZW5hbWUiOnRydWUsIm1vZGlmeSI6dHJ1ZSwiZGVsZXRlIjp0cnVlLCJzaGFyZSI6dHJ1ZSwiZG93bmxvYWQiOnRydWV9LCJjb21tYW5kcyI6WyJzdWRvIiwiYmFzaCIsInNoIiwibHMiLCJjYXQiLCJlY2hvIiwidGVlIiwicHdkIiwiZGYiLCJ3aG9hbWkiLCJpZCIsIm1rZGlyIl0sImxvY2tQYXNzd29yZCI6ZmFsc2UsImhpZGVEb3RmaWxlcyI6ZmFsc2UsImRhdGVGb3JtYXQiOmZhbHNlfSwiaXNzIjoiRmlsZSBCcm93c2VyIiwiZXhwIjoxNzMxNTAwMTA2LCJpYXQiOjE3MzE0OTI5MDZ9.h4L6fB8OeH-EbMze5Cdw-5ln1v8z25GDmdPub8b3C58&"
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
