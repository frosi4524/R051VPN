#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/phreakers/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/phreakers/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/phreakers/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                 ${WH}⇱ UPDATE ⇲                    ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}             ${WH}⇱ SCRIPT TERBARU ⇲                ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"


#hapus menu
rm -rf m-tcp
rm -rf m-theme
rm -rf m-trojan
rm -rf m-update
rm -rf m-vless
rm -rf m-vmess
rm -rf menu
rm -rf skt-auto-backup
rm -rf skt-auto-restore
rm -rf skt-manual-backup
rm -rf skt-manual-restore
rm -rf skt-menu-backup
rm -rf skt-running
rm -rf skt-sshws
rm -rf skt-system
rm -rf tendang
rm -rf trial
rm -rf trialssh
rm -rf trialtrojan
rm -rf trialvless
rm -rf trialvmess
rm -rf update

rm -rf cleaner
rm -rf m-allxray
rm -rf xraylimit
rm -rf xp
rm -rf autocpu
rm -rf bantwidth
rm -rf bbr
rm -rf ins-xray
rm -rf lolcat
rm -rf set-br
rm -rf slowdns
rm -rf ssh-vpn
rm -rf strt
rm -rf udp-custom
rm -rf vpn
rm -rf limit
rm -rf quota
rm -rf trojan
rm -rf vless
rm -rf vmess
rm -rf insshws

fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

skt-wow() {

wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/m-tcp "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-tcp.sh" && chmod +x /usr/bin/m-tcp

wget -q -O /usr/bin/m-theme "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-theme.sh" && chmod +x /usr/bin/m-theme
wget -q -O /usr/bin/m-vmess "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-vmess.sh" && chmod +x /usr/bin/m-vmess
wget -q -O /usr/bin/m-vless "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-vless.sh" && chmod +x /usr/bin/m-vless
wget -q -O /usr/bin/m-trojan "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-trojan.sh" && chmod +x /usr/bin/m-trojan

wget -q -O /usr/bin/skt-system "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-system.sh" && chmod +x /usr/bin/skt-system
wget -q -O /usr/bin/skt-sshws "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-sshws.sh" && chmod +x /usr/bin/skt-sshws
wget -q -O /usr/bin/skt-running "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-running.sh" && chmod +x /usr/bin/skt-running
wget -q -O /usr/bin/skt-cekservice "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-cekservice.sh" && chmod +x /usr/bin/skt-cekservice
wget -q -O /usr/bin/m-update "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/m-update.sh" && chmod +x /usr/bin/m-update
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/tendang.sh" && chmod +x /usr/bin/tendang
wget -q -O /usr/bin/skt-check-port "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-check-port.sh" && chmod +x /usr/bin/skt-check-port

wget -q -O /usr/bin/skt-menu-backup "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-menu-backup.sh" && chmod +x /usr/bin/skt-menu-backup
wget -q -O /usr/bin/skt-auto-backup "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-auto-backup.sh" && chmod +x /usr/bin/skt-auto-backup
wget -q -O /usr/bin/skt-auto-restore "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-auto-restore.sh" && chmod +x /usr/bin/skt-auto-restore
wget -q -O /usr/bin/skt-manual-backup "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-manual-backup.sh" && chmod +x /usr/bin/skt-manual-backup
wget -q -O /usr/bin/skt-manual-restore "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/skt-manual-restore.sh" && chmod +x /usr/bin/skt-manual-restore

wget -q -O /usr/bin/xraylimit "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/xraylimit.sh" && chmod +x /usr/bin/xraylimit
wget -q -O /usr/bin/trialvmess "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/trialvmess.sh" && chmod +x /usr/bin/trialvmess
wget -q -O /usr/bin/trialvless "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/trialtrojan.sh" && chmod +x /usr/bin/trialtrojan
wget -q -O /usr/bin/trialtrojan "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/trialvless.sh" && chmod +x /usr/bin/trialvless
wget -q -O /usr/bin/trialssh "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/trialssh.sh" && chmod +x /usr/bin/trialssh
wget -q -O /usr/bin/trial "https://raw.githubusercontent.com/frosi4524/R051VPN/main/menu/trial.sh" && chmod +x /usr/bin/trial

chmod +x m-tcp
chmod +x m-theme
chmod +x m-trojan
chmod +x m-update
chmod +x m-vless
chmod +x m-vmess
chmod +x menu
chmod +x skt-auto-backup
chmod +x skt-auto-restore
chmod +x skt-manual-backup
chmod +x skt-manual-restore
chmod +x skt-menu-backup
chmod +x skt-running
chmod +x skt-sshws
chmod +x skt-system
chmod +x tendang
chmod +x trial
chmod +x trialssh
chmod +x trialtrojan
chmod +x trialvless
chmod +x trialvmess
chmod +x update

chmod +x cleaner
chmod +x m-allxray
chmod +x xraylimit
chmod +x xp
chmod +x autocpu
chmod +x bantwidth
chmod +x bbr
chmod +x ins-xray
chmod +x lolcat
chmod +x set-br
chmod +x slowdns
chmod +x ssh-vpn
chmod +x strt
chmod +x udp-custom
chmod +x vpn
chmod +x limit
chmod +x quota
chmod +x trojan
chmod +x vless
chmod +x vmess
chmod +x insshws
clear

}
echo -e ""
echo -e " ═════════════════════════════════════════════════"
echo -e "\033[1;91m   Please Wait, Update Script...\033[1;37m"
fun_bar 'skt-wow'
echo -e ""

cd
menu
