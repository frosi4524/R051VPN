#!/bin/bash
clear

date=$(date +"%Y-%m-%d")
vps_ip=$(curl -s ifconfig.me)
domain=$(cat /etc/xray/domain 2>/dev/null || echo "Tidak ditemukan")

# Warna
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Path backup
BACKUP_DIR="/root/backup"
ZIP_FILE="/root/backup-${date}.zip"
GDRIVE_FOLDER="vps-backup"  # Folder di Google Drive (nama folder remote)

# Siapkan folder backup
rm -rf $BACKUP_DIR
mkdir -p $BACKUP_DIR

# Salin file penting
cp -r /etc/passwd $BACKUP_DIR/
cp -r /etc/group $BACKUP_DIR/
cp -r /etc/shadow $BACKUP_DIR/
cp -r /etc/gshadow $BACKUP_DIR/
cp -r /etc/issue.net $BACKUP_DIR/
cp -r /etc/xray $BACKUP_DIR/xray 2>/dev/null
cp -r /home/vps/public_html $BACKUP_DIR/public_html 2>/dev/null
cp -r /etc/per $BACKUP_DIR/per 2>/dev/null
cp -r /etc/perlogin $BACKUP_DIR/perlogin 2>/dev/null
cp -r /etc/vmess $BACKUP_DIR/vmess 2>/dev/null
cp -r /etc/vless $BACKUP_DIR/vless 2>/dev/null
cp -r /etc/trojan $BACKUP_DIR/trojan 2>/dev/null

# Buat zip
cd /root
zip -r $ZIP_FILE backup > /dev/null 2>&1

# Upload ke Google Drive (folder gdrive:/vps-backup/)
echo -e "${GREEN}⏳ Uploading ke Google Drive...${NC}"
rclone mkdir gdrive:${GDRIVE_FOLDER}
rclone move $ZIP_FILE gdrive:${GDRIVE_FOLDER}/

# Info
echo -e "${GREEN}✅ Backup berhasil dikirim ke Google Drive!${NC}"
echo -e "📁 File: backup-${date}.zip"
echo -e "🌐 IP VPS: ${vps_ip}"
echo -e "🌍 Domain: ${domain}"
echo -e "${NC}"
