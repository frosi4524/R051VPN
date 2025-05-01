#!/bin/bash
clear

date=$(date +"%Y-%m-%d")
vps_ip=$(curl -s ifconfig.me) # Mendapatkan IP VPS
domain=$(cat /etc/xray/domain 2>/dev/null || echo "Tidak ditemukan") # Mendapatkan domain, jika ada

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BIRU='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
CYAN_BG='\033[46;1;97m'   # Latar belakang cyan cerah dengan teks putih
LIGHT='\033[0;37m'
PINK='\033[0;35m'
ORANGE='\033[38;5;208m'
PINK_BG='\033[45;1;97m'
BIRU_BG='\033[44;1;97m'
RED_BG='\033[41;1;97m'   # Latar belakang pink cerah dengan teks putih
NC='\033[0m'
INDIGO='\033[38;5;54m'
TEAL='\033[38;5;30m'
WHITE='\033[1;37m'

CHATID="727253762"
KEY="7914407621:AAGO9kJzXE0FgjBLNoRMBAx52WQC6Y9PuXE"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
IP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
date=$(date +"%Y-%m-%d")
clear
email=$(cat /root/email)
if [[ "$email" = "" ]]; then
clear
echo "Masukkan Email Untuk Menerima Backup"
echo -e ""
echo -e "\033[1;93m_____________________________________________________\033[0m" | tee -a /etc/user-create/user.log
read -rp "Input Your Email : " -e email
echo -e "\033[1;93m_____________________________________________________\033[0m" | tee -a /etc/user-create/user.log
cat <<EOF>>/root/email
$email
EOF
fi
clear
echo -e "\033[1;93m_____________________________________________________\033[0m" | tee -a /etc/user-create/user.log
echo -e "\033[1;92mWait Backup Procces.......\033[0m"
echo -e "\033[1;93m_____________________________________________________\033[0m" | tee -a /etc/user-create/user.log
# Fungsi untuk backup data manual
clear
source /etc/skt/token.json
if [ -f "/etc/skt/token.json" ]; then
rm -rf /root/backup
mkdir /root/backup
cp -r /etc/passwd /root/backup/ &> /dev/null
cp -r /etc/group /root/backup/ &> /dev/null
cp -r /etc/shadow /root/backup/ &> /dev/null
cp -r /etc/gshadow /root/backup/ &> /dev/null
cp -r /usr/bin/idchat /root/backup/ &> /dev/null
cp -r /usr/bin/token /root/backup/ &> /dev/null
cp -r /etc/per/id /root/backup/ &> /dev/null
cp -r /etc/per/token /root/backup/token2 &> /dev/null
cp -r /etc/perlogin/id /root/backup/loginid &> /dev/null
cp -r /etc/perlogin/token /root/backup/logintoken &> /dev/null
cp -r /etc/xray/config.json /root/backup/xray &> /dev/null
cp -r /etc/xray/ssh /root/backup/ssh &> /dev/null
cp -r /home/vps/public_html /root/backup/public_html &> /dev/null
cp -r /etc/xray/sshx /root/backup/sshx &> /dev/null
cp -r /etc/vmess /root/backup/vmess &> /dev/null
cp -r /etc/vless /root/backup/vless &> /dev/null
cp -r /etc/trojan /root/backup/trojan &> /dev/null
cp -r /etc/issue.net /root/backup/issue &> /dev/null
cd /root
zip -r backup.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   ⚠️BACKUP NOTIF⚠️</b>
<b>     Detail Backup VPS</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>IP VPS  :</b> <code>${IP} </code>
<b>DOMAIN :</b> <code>${domain}</code>
<b>Tanggal : $date</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>Link Backup   :</b> $link
<code>◇━━━━━━━━━━━━━━◇</code>
<code>Silahkan copy Link dan restore di VPS baru</code>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
echo ""
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
"
echo "Silahkan copy Link dan restore di VPS baru"
echo ""
