#!/bin/bash

#主程序开始

# fonts color
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
bold(){
    echo -e "\033[1m\033[01m$1\033[0m"
}

updateSystem() {
   #安装更新运行环境（Debian系统）
  green "=========Running 安装更新运行环境========="
  apt update -y && apt dist-upgrade -y && apt install -y curl && apt install -y socat
  wait
  green "=========Running 安装更新运行环境========="
  apt-get install -y xz-utils openssl gawk file wget screen && screen -S os
}

changeSystem() {
  # 更改SSH终端中文语言
  green "=========Running 更改SSH终端语言========="
  wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/LocaleCN/master/LocaleCN.sh && bash LocaleCN.sh
  wait
  # 更改服务器时区为上海
  green "=========Running 更改服务器时区========="
  timedatectl set-timezone 'Asia/Shanghai'
}

installPanel() {
  #首先宝塔面板7.7原版
  green -e "=========Running 安装宝塔面板7.7原版=========\n"
  curl -sSO https://raw.githubusercontent.com/zhucaidan/btpanel-v7.7.0/main/install/install_panel.sh && bash install_panel.sh
}

changePanel() {
   #然后执行一键开心脚本
  green "=========Running 一键开心脚本========="
  curl -sSO https://raw.githubusercontent.com/ztkink/bthappy/main/one_key_happy.sh && bash one_key_happy.sh
}

repairPanel() {
  #最后执行下一键优化补丁
  green "=========Running 优化补丁========="
  wget -O optimize.sh https://raw.luolix.top/luolixman/tool/main/optimize.sh && bash optimize.sh
}

installXui() {
  green "安装X-ui面板"
  bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh)
}

installDocker() {
  green "安装docker(国内)"
  curl -sSL https://get.daocloud.io/docker | sh
}

installTelegram() {
  green "安装TG代理"
  apt install -y curl
  bash <(curl -sL https://s.hijk.art/mtproto.sh)
}

openOneShell() {
  green "多功能一键脚本"
  bash <(curl -Lso- https://git.io/oneclick)
}


function start_menu() {
  clear
  echo
  green " ======================================="
  green "          Luolix 便捷安装脚本"
  green " ======================================="
  echo 
  green "1. 更新运行环境"
  green "2. 更改SSH语言和服务器时区"
  green "3. 安装原宝塔7.7"
  green "4. 一键宝塔开心"
  green "5. 安装优化补丁"
  green "6. 安装X-ui面板"
  green "7. 安装docker(国内)"
  green "8. 安装TG代理"
  green "9. 多功能一键脚本"
  green "0. 退出脚本"
  
  
  echo
  read -p "请选择你的序号:" menuNumberInput
    case "$menuNumberInput" in
        1 )
            updateSystem
            sleep 3s
            start_menu
        ;;
        2 )
            changeSystem
            sleep 3s
            start_menu
        ;;
        3 )
            installPanel
            start_menu
        ;;
        4 )
            changePanel
            start_menu
        ;;
        5 )
            repairPanel
            start_menu
        ;;
        6 )
            installXui
            start_menu
        ;;
        7 )
            installDocker
            start_menu
        ;;
        8 )
            installTelegram
            start_menu
        ;;
        9 )
            openOneShell
            start_menu
        ;;
        0 )
        green "退出脚本"
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            sleep 2s
            start_menu
        ;;
     esac
}

start_menu
#end
