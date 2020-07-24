#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
apt-get install lsof >/dev/null 2>&1
apt-get install sudo >/dev/null 2>&1
apt-get install cowsay -y >/dev/null 2>&1
apt-get install lolcat -y >/dev/null 2>&1
apt-get install figlet -y >/dev/null 2>&1
apt-get install php -y >/dev/null 2>&1
apt-get install jq -y >/dev/null 2>&1
cd $HOME
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || apt-get install mlocate -y &>/dev/null
rm $(pwd)/$0 &> /dev/null
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="\e[1;33m<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=>=<=><>=<=><=>\e[1;33m" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="${AZUL}${NEGRITO}========================================" && echo -e "${cor}${SEMCOR}";;
 esac
}
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
inst_components () {
	apt-get install php -y >/dev/null 2>&1
apt-get install jq -y >/dev/null 2>&1
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
}
funcao_idioma () {
msg -bar2
echo -e "\e[1;33mSelecione Un Idioma\e[0m"
msg -bar2
declare -A idioma=( [1]="en English" [2]="fr Franch" [3]="de German" [4]="it Italian" [5]="pl Polish" [6]="pt Portuguese" [7]="es Spanish" [8]="tr Turkish" )
for ((i=1; i<=12; i++)); do
valor1="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor1 ]] && break
valor1="\033[1;32m[$i] > \033[0;31m$valor1"
    while [[ ${#valor1} -lt 37 ]]; do
       valor1=$valor1" "
    done
echo -ne "$valor1"
let i++
valor2="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor2 ]] && {
   echo -e " "
   break
   }
valor2="\033[1;32m[$i] > \033[0;31m$valor2"
     while [[ ${#valor2} -lt 37 ]]; do
        valor2=$valor2" "
     done
echo -ne "$valor2"
let i++
valor3="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor3 ]] && {
   echo -e " "
   break
   }
valor3="\033[1;32m[$i] > \033[0;31m$valor3"
     while [[ ${#valor3} -lt 37 ]]; do
        valor3=$valor3" "
     done
echo -e "$valor3"
done
msg -bar2
unset selection
while [[ ${selection} != @([1-8]) ]]; do
echo -ne "\033[1;37mSELECIONE: " && read selection
tput cuu1 && tput dl1
done
pv="$(echo ${idioma[$selection]}|cut -d' ' -f1)"
[[ ${#id} -gt 2 ]] && id="pt" || id="$pv"
byinst="true"
}
install_fim () {
clear
msg -ama "               Finalizando Instalacion" && msg bar2
[[ $(find /etc/newadm/ger-user -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/newadm/ger-user/nombre.log https://github.com/Mordy-03/AMX/raw/master/ArchivosUtilitarios/nombre.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/newadm/ger-user/IDT.log https://raw.githubusercontent.com/Mordy-03/AMX/master/IDT.log &>/dev/null
wget -O /bin/rebootnb https://github.com/Mordy-03/AMX/raw/master/ArchivosUtilitarios/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://github.com/Mordy-03/AMX/raw/master/ArchivosUtilitarios/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://github.com/Mordy-03/AMX/raw/master/Vercion &>/dev/null
msg -bar2
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'echo ""' >> .bashrc
echo 'echo -e "\033[1;31m𝙑𝙋𝙎 𝙈𝘼𝙉𝘼𝙂𝙀𝙍 𝘼𝙈𝙓 // 𝙑𝙀𝙍𝙎𝙄𝙊𝙉 𝙊𝙋𝙏𝙄𝙈𝙄𝙕𝘼𝘿𝘼 // 𝙀𝙎       " '>> .bashrc
echo 'echo "" '>> .bashrc 
echo 'echo -e "\033[1;33mTelegram:\033[1;30m @MordretOficial " '>> .bashrc                                       
echo 'echo -e "\033[1;33mVersion instalada:\033[1;30m V.1.0 " '>> .bashrc                    
echo 'echo -e "\033[1;33mPara mostrar el Panel escribe: \033[1;31m 𝗦𝗨𝗗𝗢 𝗠𝗘𝗡𝗨   "'>> .bashrc
echo 'wget -O /etc/versin_script_new https://github.com/Mordy-03/AMX/raw/master/Vercion &>/dev/null'>> .bashrc
echo 'echo ""'>> .bashrc
echo -e "         COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
echo -e "\033[1;41m                     sudo menu                        \033[0;37m" && msg -bar2
sleep 5
}
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
[[ ! -d ${SCPfrm3} ]] && mkdir ${SCPfrm3}
case $1 in
"menu"|"message.txt")ARQ="${SCPdir}/";; #Menu
"dados.zip")ARQ="${SCPfrm3}/";; #painel
"painel.zip")ARQ="${SCPfrm3}/";; #painel
"usercodes")ARQ="${SCPusr}/";; #User
"openssh.sh")ARQ="${SCPinst}/";; #Instalacao
"squid.sh")ARQ="${SCPinst}/";; #Instalacao
"dropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh")ARQ="${SCPinst}/";; #Instalacao
"ssld.sh")ARQ="${SCPinst}/";; #Instalacao
"sslmanager.sh")ARQ="${SCPinst}/";; #Instalacao
"errormanager.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsock.sh")ARQ="${SCPinst}/";; #Instalacao
"shadown.sh")ARQ="${SCPinst}/";; #Instalacao
"ssrrmu.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"v2ray.sh")ARQ="${SCPinst}/";; #Instalacao
"vdoray.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
fun_ip
wget -O /usr/bin/trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 &> /dev/null
clear
msg -bar2
figlet ADM-CODE20 | lolcat
msg -bar2
msg -bra "\E[93m               [ VENTA DE KEYS AL +52 9581736439 ]             \E[93m"
echo -e " "
msg -bar2
msg -bra "\E[93m         [ INSTALADOR OFICIAL ]\E[93m \E[93m[ ADM-PRO-2020-MORDRET-OFICIAL]     \E[93m"
echo " "
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
error_fun () {
msg -bar2 && msg -verm "$(source trans -b es:${id} "Esta Key era de otro servidor por lo que fue excluida"|sed -e 's/[^a-z -]//ig') " && msg -bar2
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
exit 1
}
invalid_key () {
msg -bar2 && msg -verm "Key no valida! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
exit 1
}
while [[ ! $Key ]]; do
msg -ne "# KEY # : " && read Key
tput cuu1 && tput dl1
done
msg -ne "Key: "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Verificando" || {
   echo -e "\033[1;32m Verificando"
   invalid_key
   exit
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -ama "$(source trans -b es:${id} "BIENVENIDO, GRACIAS POR UTILIZAR"|sed -e 's/[^a-z -]//ig'): \E[41;1;37m[NEW-ADM-PRO]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="*"
   stopping="$(source trans -b es:${id} "Verificando Atualizaciones"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="*"
   done
   sleep 1s
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/adm && chmod +x /usr/bin/adm
   inst_components
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "pt" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   [[ ${byinst} = "true" ]] && install_fim
else
invalid_key
fi
