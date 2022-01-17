#!/bin/bash
# Author of the script : powen

# Check source and permission
cd "$(dirname "$0")"
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    wget https://github.com/powenn/AltServer-Linux-ShellScript/raw/main/AltStore.ipa
fi
if [[ ! -e "ipa" ]]; then
    mkdir ipa
fi
if [[ ! -e "saved.txt" ]]; then
    touch saved.txt
fi
if [[ "stat AltServer | grep -rw-r--r--" != "" ]] ; then
    chmod +x AltServer
fi
if [[ "stat AltServerDaemon | grep -rw-r--r--" != "" ]] ; then
    chmod +x AltServerDaemon
fi

#####
HasExistAccount=$(cat saved.txt)
UDID=$(lsusb -v 2> /dev/null | grep -e "Apple Inc" -A 2 | grep iSerial | awk '{print $3}')
HasExistipa=$(ls ipa)


# Instruction
cat << EOF >help.txt
    
#####################################
#  歡迎到AltServer腳本  #
#####################################

用法: [選項]

選項

  1, --Install AltStore
    下載AltStore到你的裝置中
  2, --Install ipa
    從「ipa」資料夾內下載ipa檔，在執行此指令前請確定已經在「ipa」資料夾內放置任何ipa檔案
  d, --Daemon mode
    切換到守護進程模式已在AltStore上重簽或下載ipa檔
  e, --exit
    退出
  h, --help
    顯示此訊息
     
EOF

# Print AltServer icon
AltServerIcon() {
    printf "\e[49m       \e[38;5;73;49m▄▄\e[38;5;66;49m▄\e[38;5;66;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;66;49m▄\e[38;5;73;49m▄▄\e[49m       \e[m
\e[49m     \e[38;5;73;49m▄\e[38;5;66;48;5;73m▄\e[38;5;66;48;5;66m▄▄▄▄▄▄\e[38;5;67;48;5;66m▄▄\e[38;5;66;48;5;66m▄▄▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;73;49m▄\e[49m     \e[m
\e[49m   \e[38;5;73;49m▄\e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;109;48;5;73m▄\e[38;5;109;48;5;109m▄▄▄▄\e[38;5;109;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[38;5;73;49m▄\e[49m   \e[m
\e[49m \e[38;5;73;49m▄\e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;30;48;5;30m▄▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[38;5;73;49m▄\e[49m \e[m
\e[49m \e[38;5;30;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[38;5;15;48;5;15m▄▄\e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;30m▄\e[38;5;30;48;5;30m▄▄▄▄▄\e[38;5;30;48;5;73m▄\e[49m \e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄▄\e[38;5;73;48;5;30m▄▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[38;5;15;48;5;15m▄\e[48;5;15m    \e[38;5;15;48;5;15m▄\e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;30m▄▄\e[38;5;30;48;5;30m▄▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄\e[38;5;66;48;5;30m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;15;48;5;73m▄\e[48;5;15m          \e[38;5;15;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;66;48;5;30m▄\e[38;5;30;48;5;30m▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;30;48;5;30m▄▄\e[38;5;30;48;5;66m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[48;5;15m          \e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;30;48;5;66m▄\e[38;5;30;48;5;30m▄▄\e[38;5;73;48;5;73m▄\e[m
\e[38;5;73;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄\e[38;5;6;48;5;66m▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[38;5;15;48;5;15m▄\e[48;5;15m    \e[38;5;15;48;5;15m▄\e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;72m▄\e[38;5;6;48;5;6m▄▄▄\e[38;5;73;48;5;73m▄\e[m
\e[49m \e[38;5;73;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;73;48;5;15m▄\e[38;5;15;48;5;15m▄▄\e[38;5;73;48;5;15m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄\e[38;5;73;48;5;6m▄\e[49m \e[m
\e[49m \e[49;38;5;66m▀\e[38;5;67;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄▄▄▄▄\e[38;5;6;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;67;48;5;6m▄\e[49;38;5;66m▀\e[49m \e[m
\e[49m   \e[49;38;5;67m▀\e[38;5;66;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;73;48;5;73m▄▄▄▄\e[38;5;66;48;5;73m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;6m▄\e[49;38;5;67m▀\e[49m   \e[m
\e[49m     \e[49;38;5;66m▀\e[38;5;66;48;5;6m▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;6;48;5;30m▄▄\e[38;5;6;48;5;6m▄▄▄▄▄▄\e[38;5;66;48;5;6m▄\e[49;38;5;66m▀\e[49m     \e[m
\e[49m       \e[49;38;5;66m▀▀\e[49;38;5;6m▀\e[38;5;66;48;5;6m▄▄▄▄▄▄▄▄\e[49;38;5;6m▀\e[49;38;5;66m▀▀\e[49m       \e[m
";
}

# Check if there exists saved account
# Ask if want to use saved account
AskAccount() {
    if [[ "$HasExistAccount" != "" ]]; then
        echo "你想要使用已儲存的帳號嗎 ? [y/n]"
        read reply
        case "$reply" in
        [yY][eE][sS]|[yY] )
        echo "請選擇帳號 "
        UseExistAccount=1
        nl saved.txt
        echo "請輸入編號 "
        read number
        ExistID=$(sed -n "$number"p saved.txt | cut -d , -f 1)
        ExistPasswd=$(sed -n "$number"p saved.txt | cut -d , -f 2)
        ;;
        [nN][oO]|[nN] )
        UseExistAccount=0
        ;;
        esac
    fi
    if [[ "$HasExistAccount" == "" ]]; then
        UseExistAccount=0
    fi
    if [[ $UseExistAccount = 0 ]]; then
        echo "請輸入Apple ID"
        read AppleID
        echo "請輸入密碼"
        read password
    fi
}

# Execute AltServer
# Check if this account existed before
AltServer() {
    if [[ $UseExistAccount = 1 ]]; then
        ./AltServer -u ${UDID} -a $ExistID -p $ExistPasswd $PATH
    fi
    if [[ $UseExistAccount = 0 ]]; then
        ./AltServer -u ${UDID} -a $AppleID -p $password $PATH
    fi
    if [[ "$CheckAccount" == "" ]] ; then
        RunScript=1
    fi
    if [[ "$CheckAccount" != "" ]] ; then
        exit
    fi
}

# Check if there exists ipa files in ipa folder
ipaCheck() {
    if [[ "$HasExistipa" != "" ]]; then
        echo "請輸入ipa的編號 "
        echo "$HasExistipa" > ipaList.txt
        nl ipaList.txt
        read ipanumber
        Existipa=$(sed -n "$ipanumber"p ipaList.txt )
    else
        echo "在「ipa」資料夾內沒有任何ipa檔 "
        exit
    fi
}

# Ask to save the new account
SaveAcccount() {
    echo "你要儲存此帳號嗎 ? [y/n]"
    read ans
    case "$ans" in
    [yY][eE][sS]|[yY] )
    echo "$Account" >> saved.txt
    echo "已儲存"
    exit
    ;;
    [nN][oO]|[nN] )
    exit
    ;;
    esac
}

# Start script
AltServerIcon
cat help.txt
echo "請連接裝置到電腦"
read key
idevicepair pair

RunScript=0
while [ $RunScript = 0 ] ; do
    echo "請輸入選項以繼續"
    read option
    case "$option" in
    
  1|--Install-ipa )
  
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    AskAccount
    
    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./AltStore.ipa
    
    AltServer
    ;;
    
  2|--Install-ipa )
  
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ipaCheck
    AskAccount

    Account=$AppleID,$password
    CheckAccount=$(grep $Account saved.txt)
    PATH=./ipa/$Existipa
    
    AltServer
    ;;
        
  d|--Daemon-mode )
    for job in `jobs -p`
    do
    wait $job
    done

    idevicepair pair
    ./AltServerDaemon
    ;;
  e|--exit )
    exit
    ;;
  h|--help )
    AltServerIcon
    cat help.txt
    ;;
    esac

done

while [ $RunScript = 1 ] ; do
    SaveAcccount
done
