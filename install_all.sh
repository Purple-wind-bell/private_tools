# 1 安装系统环境
# 1.1 安装docker engine
sudo apt-get remove docker docker-engine docker.io containerd runc -y &&
    sudo apt-get update &&
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y &&
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null &&
    sudo apt-get update &&
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&

    # 1.2 安装docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
    sudo chmod +x /usr/local/bin/docker-compose &&
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose &&
    docker-compose --version

# 1.3 配置adguardhome守护进程,DNSStubListener
if [ ! -d "/etc/systemd/resolved.conf.d/" ]; then
    echo "文件夹不存在，创建文件夹" &&
        mkdir /etc/systemd/resolved.conf.d
fi
echo '[Resolve]
DNS=127.0.0.1
DNSStubListener=no' \
>/etc/systemd/resolved.conf.d/adguardhome.conf &&
    sudo mv /etc/resolv.conf /etc/resolv.conf.backup &&
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf &&
    sudo systemctl reload-or-restart systemd-resolved

# 2 部署docker，注意xray必须有证书才能启动
for dir in $(ls .); do
    if
        [[ -d $dir &&
            $dir != "acme" && $dir != "owncloud" ]]
    then
        echo $dir &&
            cd $dir &&
            docker-compose down &&
            docker-compose up -d &&
            cd ..
    fi
done

# # 3 申请并安装证书
# # 3.1 部署docker版acme.sh
# cd acme
# docker-compose down
# docker-compose up -d
# cd ..
# # # 3.2申请证书 docker exec acme.sh --issue -d $website_name -d $website_all_name --dns dns_cf
# docker exec acme.sh --issue -d $website_name -d $website_all_name --dns dns_cf
# # # 3.3 安装证书
# docker exec acme.sh --deploy -d $website_all_name --deploy-hook docker

# 4 安装优化
# 4.1 安装配置bbr
sudo apt update && sudo apt upgrade -y
sudo echo "net.core.default_qdisc=fq" >>/etc/sysctl.conf
sudo echo "net.ipv4.tcp_congestion_control=bbr" >>/etc/sysctl.conf
# sudo reboot
