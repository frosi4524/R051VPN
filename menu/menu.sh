#!/bin/bash


# Dependency Check
if ! command -v jq &> /dev/null; then
    apt-get install -y jq > /dev/null 2>&1
fi

# IP Information Setup
IPINFO_TOKEN="17edb1996336c1"  # Ganti dengan token Anda

# System Information
get_sys_info() {
    # OS Info
    OS=$(lsb_release -ds | sed 's/"//g' 2>/dev/null || cat /etc/*release | head -n1)
    SERONLINE=$(uptime -p | cut -d " " -f 2-10000)

    # Memory Info
    RAM=$(free -m | awk '/Mem:/ {printf "%.0fM", $2}')
    SWAP=$(free -m | awk '/Swap:/ {printf "%.0fM", $2}')
    
    # CPU Info
    CORE=$(nproc)
    CPU_USAGE=$(top -bn1 | awk '/Cpu/ {printf "%.1f%%", 100 - $8}')
}


# Fungsi untuk memeriksa IP dan mendapatkan client_name dan exp_date
check_ip_and_get_info() {
    local ip=$1
    local line
    while IFS= read -r line; do
        if [[ $line == *"$ip"* ]]; then
            client_name=$(echo "$line" | awk '{print $2}')
            exp_date=$(echo "$line" | awk '{print $4}')
            return 0
        fi
    done <<< "$permission_file"
    return 1
}

# Mengambil data client dan expdate dari URL
permission_file=$(curl -s https://raw.githubusercontent.com/frosi4524/1z1n/main/L1cense.txt)

# Mengambil informasi sistem
OS=$(lsb_release -ds)
RAM=$(free -m | awk '/Mem:/ { print $2 }')
UPTIME=$(uptime -s)
current_time=$(date "+%Y-%m-%d %H:%M:%S")
total_uptime=$(date -ud@$(( $(date -d "$current_time" +%s) - $(date -d "$UPTIME" +%s) )) +'%j days, %H hours')
# Hilangkan nol di depan pada days dan hours
formatted_uptime=$(echo "$total_uptime" | sed 's/^0*//; s/, 0*/, /')
IP_VPS=$(hostname -I | awk '{print $1}')
ISP=$(curl -s ipinfo.io/org)
DOMAIN=$(cat /etc/xray/domain)

# Mengambil informasi IP lengkap dari ipinfo.io
IP_INFO=$(curl -s "http://ipinfo.io/$IP_VPS/json")
IP_REGION=$(echo "$IP_INFO" | jq -r '.region')
IP_COUNTRY=$(echo "$IP_INFO" | jq -r '.country')
IP_LOC=$(echo "$IP_INFO" | jq -r '.loc')

# Periksa IP terlebih dahulu
echo -e "${GREEN}⌛ Sabar Sedang Memeriksa IP...${NC}"
sleep 1
clear

if check_ip_and_get_info "$IP_VPS"; then
    :
else
    echo -e "${RED}IP not found in our database${NC}"
   echo -e "➥ Contact admin ${CYAN}「 ✦ @SaputraTech ✦ 」${NC}"
    exit 1
fi

# Periksa apakah skrip sudah kedaluwarsa
current_date=$(date +%Y-%m-%d)
if [[ "$exp_date" != "Not Found" && $(date -d "$exp_date" +%Y-%m-%d) < $(date -d "$current_date" +%Y-%m-%d) ]]; then
    echo -e "${GREEN}[ INFO ]${NC} ${RED}Script Expired !!!${NC}"
   echo -e "➥ Contact admin ${CYAN}「 ✦ @SaputraTech ✦ 」${NC}"
    exit 1
fi

# Menghitung sisa hari
if [[ "$exp_date" != "Not Found" ]]; then
    days_remaining=$(( ($(date -d "$exp_date" +%s) - $(date -d "$current_date" +%s)) / 86400 ))
    exp_message="$days_remaining ${YELLOW}days remaining${NC}"
else
    exp_message="Not Found"
fi

# Network Information
get_net_info() {
    # IP Address
    IPVPS=$(curl -s4 --connect-timeout 3 ifconfig.me || curl -s4 --connect-timeout 3 ipinfo.io/ip || echo "Unknown")
    
    # ISP & City with fallback
    local ipinfo_response=$(curl -s "https://ipinfo.io?token=$IPINFO_TOKEN")
    ISP=$(echo "$ipinfo_response" | jq -r '.org // empty' | cut -d ' ' -f 2-)
    CITY=$(echo "$ipinfo_response" | jq -r '.city // empty')
    
    if [ -z "$ISP" ]; then
        ISP=$(curl -s ipapi.co/org)
    fi
    if [ -z "$CITY" ]; then
        CITY=$(curl -s ipapi.co/city)
    fi
    
    # Domain Info
    DOMAIN=$(cat /etc/xray/domain 2>/dev/null || echo "Not Set")
}

# Uptime Calculation
get_uptime() {
    uptime_sec=$(awk '{print $1}' /proc/uptime | cut -d. -f1)
    days=$((uptime_sec/86400))
    hours=$(( (uptime_sec%86400)/3600 ))
    minutes=$(( (uptime_sec%3600)/60 ))
    
    if [ $days -gt 0 ]; then
        echo "${days}d ${hours}h ${minutes}m"
    else
        echo "${hours}h ${minutes}m"
    fi
}



#######################################
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
MYIP=$(curl -sS ipv4.icanhazip.com)
#######################################
colornow=$(cat /etc/phreakers/theme/color.conf)
export NC="\e[0m"
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export yl='\033[0;33m';
export RED="\033[0;31m"
export COLOR1="$(cat /etc/phreakers/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/phreakers/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"

WH='\033[1;37m'
#######################################
# Server Information
date_server=$(date -u +"%Y-%m-%d")
wkt_server=$(timedatectl | grep "Time zone" | awk '{print $3}' | tr -d '()')

# RAM Information
tram=$(free -h | awk '/Mem:/ {print $2}')
uram=$(free -h | awk '/Mem:/ {print $3}')
#######################################
# Network Information
ipsaya=$(curl -s4 ifconfig.me)
IPVPS=$(curl -s4 ifconfig.me)
ISP=$(curl -s ipinfo.io/org | cut -d ' ' -f 2-10)
CITY=$(curl -s ipinfo.io/city)
#######################################

mai="datediff "$Exp" "$DATE""

# CERTIFICATE STATUS
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
certificate=$(( (d1 - d2) / 86400 ))

WKT=$(curl -s ipinfo.io/timezone?token=$ipn )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
MYIP=$(curl -sS ipv4.icanhazip.com)

cd
if [ ! -e /etc/per/id ]; then
  mkdir -p /etc/per
  echo "" > /etc/per/id
  echo "" > /etc/per/token
elif [ ! -e /etc/perlogin/id ]; then
  mkdir -p /etc/perlogin
  echo "" > /etc/perlogin/id
  echo "" > /etc/perlogin/token
elif [ ! -e /usr/bin/id ]; then
  echo "" > /usr/bin/idchat
  echo "" > /usr/bin/token
fi

if [ ! -e /etc/xray/ssh ]; then
  echo "" > /etc/xray/ssh
elif [ ! -e /etc/xray/sshx ]; then
  mkdir -p /etc/xray/sshx
elif [ ! -e /etc/xray/sshx/listlock ]; then
  echo "" > /etc/xray/sshx/listlock
elif [ ! -e /etc/vmess ]; then
  mkdir -p /etc/vmess
elif [ ! -e /etc/vmess/listlock ]; then
  echo "" > /etc/vmess/listlock
elif [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
elif [ ! -e /etc/vless/listlock ]; then
  echo "" > /etc/vless/listlock
elif [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
elif [ ! -e /etc/trojan/listlock ]; then
  echo "" > /etc/trojan/listlock
fi
clear
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
# usage
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba=$(curl -s https://pastebin.com/raw/0gWiX6hE)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
    bulan=$(date +%b)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $9}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $10}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $3}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $4}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
    bulan2=$(date +%Y-%m)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $8}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $9}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $2}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $3}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /etc/t1)" != '0' ]; then
    yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
    yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
    yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
    yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
    yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
    yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
    yesterday=NULL
    yesterday_v=NULL
    yesterday_rx=NULL
    yesterday_rxv=NULL
    yesterday_tx=NULL
    yesterday_txv=NULL
fi

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-stunnel | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${COLOR1}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${COLOR1}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
    systemctl start nginx
fi

# // Dropbear
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $dropbear_status == "running" ]]; then
   status_beruangjatuh="${COLOR1}ON${NC}"
else
   status_beruangjatuh="${RED}OFF${NC}"
fi
# status

rm -rf /etc/status

wget -q -O /etc/status "https://raw.githubusercontent.com/frosi4524/R051VPN/main/SKT-Tools/skt-status"


# // SSH Websocket Proxy
xray=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_xray="${COLOR1}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi
# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}( Registered )${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[ EXPIRED ]${Font_color_suffix}"

today=$(date -d "0 days" +"%Y-%m-%d")
if [[ $today < $Exp2 ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^#vmg " "/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^#vlg " "/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
trtls=$(grep -c -E "^#trg " "/etc/xray/config.json")
# TOTAL ACC CREATE OVPN SSH
total_ssh=$(grep -c -E "^### " "/etc/xray/ssh")
#total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

# Main Display
clear
get_sys_info
get_net_info
clear
clear && clear && clear
clear;clear;clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               ${WH}• ROSIVPN SCRIPT AIO •            ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ $NC${WH}❈ System OS          ${COLOR1}: ${WH}$MODEL2"
echo -e "$COLOR1│ $NC${WH}❈ Memory Usage       ${COLOR1}: ${WH}$uram - $tram"
echo -e "$COLOR1│ $NC${WH}❈ Core & CPU Usage   ${COLOR1}: ${WH}$CORE GB & $cpu_usage"
echo -e "$COLOR1│ $NC${WH}❈ ISP                ${COLOR1}: ${WH}$ISP"
echo -e "$COLOR1│ $NC${WH}❈ City               ${COLOR1}: ${WH}$CITY"
echo -e "$COLOR1│ $NC${WH}❈ Domain             ${COLOR1}: ${WH}$(cat /etc/xray/domain)"
echo -e "$COLOR1│ $NC${WH}❈ IP-VPS             ${COLOR1}: ${WH}$IPVPS${NC}"
echo -e "$COLOR1│ $NC${WH}❈ Uptime             ${COLOR1}: ${WH}$SERONLINE${NC}"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═════════════════ • ${NC}${WH}STATUS SERVER${NC}${COLOR1} • ═══════════════╮${NC}"
echo -e " ${WH} SSH WS : ${status_ws} ${WH} XRAY : ${status_xray} ${WH} NGINX : ${status_nginx} ${WH} DROPBEAR : ${status_beruangjatuh}$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "   $COLOR1╭════════════════════════════════════════════╮${NC}"
echo -e "            $COLOR1$NC${WH}    LIST ACCOUNT PREMIUM ${NC}"
echo -e "   $COLOR1      ═════════════════════════════════ ${NC}"
echo -e "            $COLOR1$NC${WH}    SSH     =  ${COLOR1}$total_ssh ${NC}${WH} ACCOUNT ${NC}"
echo -e "            $COLOR1$NC${WH}    VMESS   =  ${COLOR1}$vmess ${NC}${WH} ACCOUNT ${NC}"
echo -e "            $COLOR1$NC${WH}    VLESS   =  ${COLOR1}$vless ${NC}${WH} ACCOUNT ${NC}"
echo -e "            $COLOR1$NC${WH}    TROJAN  =  ${COLOR1}$trtls ${NC}${WH} ACCOUNT${NC}"
echo -e "   $COLOR1╰═════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════ • ${NC}${WH}LIST MENU${NC}${COLOR1} • ═════════════════╮${NC}"
echo -e "$COLOR1│                                                   $COLOR1│ $NC"
echo -e "$COLOR1│ ${WH}[${COLOR1}01${WH}]${NC} ${COLOR1}• ${WH}SSH VPN  ${WH}[${COLOR1}Menu${WH}]     ${WH}[${COLOR1}06${WH}]${NC} ${COLOR1}• ${WH}RUNNING  ${WH}[${COLOR1}Menu${WH}]$COLOR1 │ $NC"
echo -e "$COLOR1│ ${WH}[${COLOR1}02${WH}]${NC} ${COLOR1}• ${WH}VMESS    ${WH}[${COLOR1}Menu${WH}]     ${WH}[${COLOR1}07${WH}]${NC} ${COLOR1}• ${WH}RESTART  ${WH}[${COLOR1}Menu${WH}]$COLOR1 │ $NC"
echo -e "$COLOR1│ ${WH}[${COLOR1}03${WH}]${NC} ${COLOR1}• ${WH}VLESS    ${WH}[${COLOR1}Menu${WH}]     ${WH}[${COLOR1}08${WH}]${NC} ${COLOR1}• ${WH}REBOOT   ${WH}[${COLOR1}Menu${WH}]$COLOR1 │ $NC"
echo -e "$COLOR1│ ${WH}[${COLOR1}04${WH}]${NC} ${COLOR1}• ${WH}TRJAN    ${WH}[${COLOR1}Menu${WH}]     ${WH}[${COLOR1}09${WH}]${NC} ${COLOR1}• ${WH}UPDATE   ${WH}[${COLOR1}Menu${WH}]$COLOR1 │ $NC"
echo -e "$COLOR1│ ${WH}[${COLOR1}05${WH}]${NC} ${COLOR1}• ${WH}BACKUP   ${WH}[${COLOR1}Menu${WH}]     ${WH}[${COLOR1}10${WH}]${NC} ${COLOR1}• ${WH}SETTING  ${WH}[${COLOR1}Menu${WH}]$COLOR1 │ $NC"
echo -e "$COLOR1│                                                   $COLOR1│ $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${WH}Traffic${NC}      ${WH}Today     Yesterday       Month       ${NC}"
echo -e "$COLOR1│ ${COLOR1}Total${NC}    ${COLOR1}  $todayd $today_v    $yesterday $yesterday_v     $month $month_v$COLOR1  ${NC} "
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"


DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}


function bannner(){
wget -O /etc/issue.net "https://raw.githubusercontent.com/frosi4524/R051VPN/main/SKT-System/issue.net" &> /dev/null
menu
}
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ $NC ${WH}Author        ${COLOR1}: ${WH}ROSI VPN STORE${NC}$COLOR1"
echo -e "$COLOR1│ $NC ${WH}Versi Script  ${COLOR1}: ${WH}$(cat /opt/.ver) Latest Version${NC}$COLOR1"
echo -e "$COLOR1│${NC} $COLOR1Client${NC}    : $client_name $COLOR1 active${NC}"
echo -e "$COLOR1│${NC} $COLOR1Exp${NC}       : $exp_message"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"; read opt
case $opt in
01 | 1) clear ; skt-sshws ;;
02 | 2) clear ; m-vmess ;;
03 | 3) clear ; m-vless ;;
04 | 4) clear ; m-trojan ;;
05 | 5) clear ; skt-menu-backup;;
06 | 6) clear ; skt-cekservice ;;
07 | 7) clear ; skt-running ;;
08 | 8) clear ; reboot ;;
09 | 9) clear ; m-update ;;
10 | 10) clear ; skt-system ;;
11 | 11) clear ; skt-menu-backup;;
99 | 99) clear ; bannner ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac