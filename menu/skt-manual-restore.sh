#!/bin/bash
clear

# Warna
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

RESTORE_DIR="/root/restore-temp"
BACKUP_FILE="backup-restore.zip"
GDRIVE_FOLDER="vps-backup" # Nama folder remote Google Drive
REMOTE_NAME="gdrive"       # Nama remote rclone

# Bersihkan direktori restore sebelumnya
rm -rf $RESTORE_DIR
mkdir -p $RESTORE_DIR
cd $RESTORE_DIR

echo -e "${YELLOW}📥 Mengunduh backup terbaru dari Google Drive...${NC}"

# Ambil file backup terbaru
LATEST_FILE=$(rclone lsjson ${REMOTE_NAME}:${GDRIVE_FOLDER} | jq -r '.[] | select(.IsDir == false) | .Name' | sort | tail -n 1)

if [[ -z "$LATEST_FILE" ]]; then
    echo -e "${RED}❌ Tidak ditemukan file backup di Google Drive.${NC}"
    exit 1
fi

rclone copy ${REMOTE_NAME}:${GDRIVE_FOLDER}/"$LATEST_FILE" $RESTORE_DIR/

if [[ ! -f "$LATEST_FILE" ]]; then
    echo -e "${RED}❌ Gagal mengunduh file backup.${NC}"
    exit 1
fi

# Ekstrak zip
echo -e "${YELLOW}📂 Mengekstrak file backup...${NC}"
unzip -o "$LATEST_FILE" > /dev/null 2>&1

if [[ ! -d "$RESTORE_DIR/backup" ]]; then
    echo -e "${RED}❌ Struktur file tidak valid. Folder backup tidak ditemukan.${NC}"
    exit 1
fi

# Restore file penting
echo -e "${YELLOW}♻️ Memulihkan data sistem...${NC}"

cp -rf backup/passwd /etc/
cp -rf backup/group /etc/
cp -rf backup/shadow /etc/
cp -rf backup/gshadow /etc/
cp -rf backup/issue.net /etc/

cp -rf backup/xray /etc/xray 2>/dev/null
cp -rf backup/public_html /home/vps/public_html 2>/dev/null
cp -rf backup/per /etc/per 2>/dev/null
cp -rf backup/perlogin /etc/perlogin 2>/dev/null
cp -rf backup/vmess /etc/vmess 2>/dev/null
cp -rf backup/vless /etc/vless 2>/dev/null
cp -rf backup/trojan /etc/trojan 2>/dev/null

echo -e "${GREEN}✅ Restore selesai! Silakan restart layanan yang diperlukan.${NC}"
