@echo off
setlocal enabledelayedexpansion
color 0A

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
set "mods[8]=TreeChopper|https://raw.githubusercontent.com/Dzxak-Cloud/Optifine/refs/heads/main/Tree-Harvester-Mod-Forge-Fabric-Quilt-1.20.1.jar"
set "mods[9]=EasierSpleeping|https://mediafilez.forgecdn.net/files/4628/693/EasierSleeping-1.20.1-2.1.3.jar"
set "mods[10]=Collective|https://mediafilez.forgecdn.net/files/5631/814/collective-1.20.1-7.84.jar"
set "mods[11]=OreExavation|https://mediafilez.forgecdn.net/files/5754/631/oreexcavation-1.13.174.jar"
set "mods[12]=SimpleVoiceChat|https://mediafilez.forgecdn.net/files/5794/966/voicechat-forge-1.20.1-2.5.24.jar"
set "mods[13]=MobHealthBar|https://mediafilez.forgecdn.net/files/4682/162/mobhealthbar-forge-1.20.1-2.2.0.jar"
set "mods[14]=SophiscatedBackpacks|https://mediafilez.forgecdn.net/files/5787/630/sophisticatedbackpacks-1.20.1-3.20.11.1115.jar"
set "mods[15]=CuriosAPI|https://github.com/Dzxak-Cloud/Optifine/raw/refs/heads/main/curios-forge-5.11.0-1.20.1.jar"
set "mods[16]=SophiscatedCore|https://mediafilez.forgecdn.net/files/5801/688/sophisticatedcore-1.20.1-0.6.34.718.jar"

cls
echo Menampilkan mods...
timeout 10
:: Tampilkan daftar mod yang akan di-download
echo Mod yang akan di download:
for /L %%i in (0, 1, 1000) do (
    if defined mods[%%i] (
        for /f "tokens=1,2 delims=|" %%a in ("!mods[%%i]!") do (
            echo - %%a
        )
    ) else (
        goto ask_confirm
    )
)

:ask_confirm
:: Konfirmasi untuk melanjutkan download
set /p confirm="Mau melanjutkan Download Mod-Mod ini? (y/n): "
if /i "%confirm%" neq "y" (
    echo Download canceled.
    goto end
)

if not exist "%mod_folder%" mkdir "%mod_folder%"

:: Loop otomatis untuk mendownload mod
for /L %%i in (0, 1, 1000) do (
    if defined mods[%%i] (
        for /f "tokens=1,2 delims=|" %%a in ("!mods[%%i]!") do (
            echo Downloading %%a...
            powershell -Command "Invoke-WebRequest -Uri '%%b' -OutFile '%mod_folder%\%%~nxb'"
        )
    ) else (
        goto done
    )
)

:done
echo Download finished.
explorer "%mod_folder%"

:end
:: Menghapus skrip setelah selesai
del "%~f0"
