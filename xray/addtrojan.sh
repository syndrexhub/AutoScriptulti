#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
read -rp "Masukkan Bug: " -e bug
tr="$(cat ~/log-install.txt | grep -w "Trojan" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Password : " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-trojan$/a\#&# '"$user $exp"'\
},{"password": "'""$user""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray.service
trojanlink="trojan://${user}@${domain}:${tr}/${bug}"
trojanlinkk="trojan://${user}@${MYIP}:${tr}/${bug}"
service cron restart
clear
echo -e ""
echo -e "══════════════════════════" | lolcat
echo -e "${RED}=•=•-xxx TROJAN-GFW   xxx-=•=•${NC}"
echo -e "══════════════════════════" | lolcat
echo -e "Remarks  : ${user}" | lolcat
echo -e "IP/Host  : ${MYIP}" | lolcat
echo -e "Address  : ${domain}" | lolcat
echo -e "Port     : ${tr}" | lolcat
echo -e "Key      : ${user}" | lolcat
echo -e "Bug      : ${bug}" | lolcat
echo -e "Created  : $hariini" | lolcat
echo -e "Expired  : $exp" | lolcat
echo -e "══════════════════════════" | lolcat
echo -e "Link TR  : ${trojanlink}" | lolcat
echo -e "══════════════════════════" | lolcat
echo -e "Link TR IP  : ${trojanlinkk}" | lolcat
echo -e "══════════════════════════" | lolcat
echo -e "${RED}AutoScriptSSH By SSHSEDANG${NC}"
echo -e "══════════════════════════" | lolcat
echo -e""
read -p "Ketik Enter Untuk Kembali Ke Menu...."
sleep 1
menu
exit 0
fi
