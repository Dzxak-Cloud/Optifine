#!/bin/bash

# Pastikan skrip berjalan dengan izin root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan sebagai root."
  exit
fi

# 1. Install Java JDK dan tmux
echo "Menginstall Java JDK dan tmux..."
apt update
apt install -y openjdk-17-jdk tmux curl

# Verifikasi instalasi Java
java -version
if [ $? -ne 0 ]; then
  echo "Gagal menginstal Java. Periksa kesalahan dan coba lagi."
  exit 1
fi

# 2. Membuat folder untuk Minecraft
echo "Membuat folder /minecraft..."
mkdir -p /minecraft
cd /minecraft

# 3. Download Forge server installer untuk versi 1.20.1, 47.3.5
FORGE_VERSION="1.20.1-47.3.5"
FORGE_INSTALLER="forge-$FORGE_VERSION-installer.jar"
echo "Mengunduh Forge server installer versi $FORGE_VERSION..."
curl -o $FORGE_INSTALLER https://maven.minecraftforge.net/net/minecraftforge/forge/$FORGE_VERSION/$FORGE_INSTALLER

if [ ! -f "$FORGE_INSTALLER" ]; then
  echo "Gagal mengunduh Forge server installer. Periksa URL dan coba lagi."
  exit 1
fi

# Jalankan installer Forge untuk membuat file server
echo "Menginstall Forge server..."
java -jar $FORGE_INSTALLER --installServer

# 4. Install FileBrowser dan set root folder ke /minecraft
echo "Mengunduh dan menginstall FileBrowser..."
curl -fsSL https://filebrowser.org/install.sh | bash

# Buat folder untuk menyimpan data konfigurasi FileBrowser
mkdir -p /etc/filebrowser
filebrowser config init -d /etc/filebrowser/filebrowser.db
filebrowser config set --database /etc/filebrowser/filebrowser.db --root /minecraft

# Tambahkan pengguna default untuk FileBrowser
filebrowser users add admin admin --perm.admin
echo "Pengguna admin untuk FileBrowser: admin / admin"

# 5. Konfigurasi tmux untuk menjalankan FileBrowser di session terpisah
echo "Membuat sesi tmux untuk FileBrowser..."
tmux filebrowser -d -s filebrowser "filebrowser -d /etc/filebrowser/filebrowser.db"

echo "Instalasi selesai!"
echo "Akses FileBrowser di http://<IP-server>:8080"
echo "Gunakan kredensial admin / admin untuk login."
