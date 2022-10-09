#!/bin/bash

#主程序开始
echo "Satrt Running"

startInstallPanel() {
  #安装更新运行环境（Debian系统）
  apt update -y && apt dist-upgrade -y && apt install -y curl && apt install -y socat
  apt-get install -y xz-utils openssl gawk file wget screen && screen -S os
  # 更改SSH终端中文语言
  wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/LocaleCN/master/LocaleCN.sh && bash LocaleCN.sh
  # 更改服务器时区为上海
  timedatectl set-timezone 'Asia/Shanghai'
  #首先宝塔面板7.7原版
  curl -sSO https://raw.githubusercontent.com/zhucaidan/btpanel-v7.7.0/main/install/install_panel.sh && bash install_panel.sh
  #然后执行一键开心脚本
  curl -sSO https://raw.githubusercontent.com/ztkink/bthappy/main/one_key_happy.sh && bash one_key_happy.sh
  #最后执行下一键优化补丁
  wget -O optimize.sh http://f.cccyun.cc/bt/optimize.sh && bash optimize.sh
}

checkSystem() {
  if [[ -n $(find /etc -name "redhat-release") ]] || grep </proc/version -q -i "centos"; then
    # 检测系统版本号
    centosVersion=$(rpm -q centos-release | awk -F "[-]" '{print $3}' | awk -F "[.]" '{print $1}')
    if [[ -z "${centosVersion}" ]] && grep </etc/centos-release "release 8"; then
      centosVersion=8
    fi
    release="centos"

  elif grep </etc/issue -q -i "debian" && [[ -f "/etc/issue" ]] || grep </etc/issue -q -i "debian" && [[ -f "/proc/version" ]]; then
    if grep </etc/issue -i "8"; then
      debianVersion=8
    fi
    startInstallPanel
    release="debian"

  elif grep </etc/issue -q -i "ubuntu" && [[ -f "/etc/issue" ]] || grep </etc/issue -q -i "ubuntu" && [[ -f "/proc/version" ]]; then
    startInstallPanel
    release="ubuntu"
  fi

  if [[ -z ${release} ]]; then
    echo "其他系统"
    exit 0
  else
    echo "当前系统为${release}"
  fi
}
checkSystem



echo "End"
