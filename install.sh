#!/bin/bash

#主程序开始
echo "Satrt Running"

startInstallPanel() {
  echo "****************Running****************"
  
  wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/LocaleCN/master/LocaleCN.sh && bash LocaleCN.sh
  wait
  timedatectl set-timezone 'Asia/Shanghai'
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
    release="debian"
    startInstallPanel

  elif grep </etc/issue -q -i "ubuntu" && [[ -f "/etc/issue" ]] || grep </etc/issue -q -i "ubuntu" && [[ -f "/proc/version" ]]; then
    release="ubuntu"
    startInstallPanel
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
