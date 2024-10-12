@echo off
setlocal enabledelayedexpansion

:: Mengatur warna teks
color 0A

:: Folder tujuan di mana mod akan disimpan
set "mod_folder=%APPDATA%\.minecraft\mods"

:: Daftar mod yang akan di-download
set "mods[0]=JourneyMap|https://mediafilez.forgecdn.net/files/5789/363/journeymap-1.20.1-5.10.3-forge.jar"
set "mods[1]=WayStone|https://mediafilez.forgecdn.net/files/5661/122/waystones-forge-1.20-14.1.5.jar"
set "mods[2]=MrCrayfish's Furniture|https://mediafilez.forgecdn.net/files/4602/980/cfm-forge-1.20.1-7.0.0-pre36.jar"
set "mods[3]=IronChest|https://mediafilez.forgecdn.net/files/4614/852/ironchest-1.20.1-14.4.4.jar"
set "mods[4]=GraveStone|https://mediafilez.forgecdn.net/files/5794/82/gravestone-forge-1.20.1-1.0.24.jar"
set "mods[5]=JEI|https://mediafilez.forgecdn.net/files/5793/297/jei-1.20.1-forge-15.20.0.104.jar"
set "mods[6]=Optifine|https://raw.githubusercontent.com/Dzxak-Cloud/Optifine/refs/heads/main/OptiFine_1.20.1_HD_U_I6.jar"
set "mods[7]=Balm|https://mediafilez.forgecdn.net/files/5644/976/balm-forge-1.20.1-7.3.9-all.jar"
set "mods[8]=BackPacked|https://mediafilez.forgecdn.net/files/4725/669/backpacked-forge-1.20.1-2.2.5.jar"

:: Tampilkan informasi jumlah mod yang akan di-download
cls
echo =====================================
echo              DOWNLOADS MOD
echo =====================================
echo Jumlah Mod yang Dipasang: 8
echo Daftar Mods:
echo -------------------------------------

for /L %%i in (0, 1, 7) do (
    for /f "tokens=1,2 delims=|" %%a in ("!mods[%%i]!") do (
        echo - %%a
    )
)

:: Tanyakan persetujuan untuk melanjutkan download
echo -------------------------------------
set /p confirm="Apakah kamu ingin melanjutkan download mod-mod ini? (y/n): "

if /i "%confirm%"=="y" (
    :: Buat folder mods jika belum ada
    if not exist "%mod_folder%" (
        mkdir "%mod_folder%"
    )

    :: Mulai proses download
    echo -------------------------------------
    echo Memulai proses download...
    for /L %%i in (0, 1, 7) do (
        for /f "tokens=1,2 delims=|" %%a in ("!mods[%%i]!") do (
            echo Mendownload %%a...
            powershell -Command "Invoke-WebRequest -Uri '%%b' -OutFile '%mod_folder%\%%~nxb'"
        )
    )

    echo.
    echo Download selesai! Mod-mod telah disimpan di %mod_folder%.

    :: Buka File Explorer di folder mods
    explorer "%mod_folder%"
    
) else (
    echo Download dibatalkan.
)

:: Menghapus file skrip batch ini setelah selesai
set "batch_file=%~f0"
ping -n 5 127.0.0.1 > nul  :: Tunggu beberapa detik sebelum menghapus
del "%batch_file%"

echo -------------------------------------
pause
