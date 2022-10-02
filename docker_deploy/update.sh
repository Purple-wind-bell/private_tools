# 更新所有容器
docker_dir=(
    containrrr-watchtower
    infrastlabs-portainer-cn
    johngong-kms
    oznu-cloudflare-ddns
    adguard-adguardhome
    onething1-wxedge-macvlan
    linuxserver-jackett
    cloudnas-clouddrive
    linuxserver-radarr
    linuxserver-sonarr-tv
    emby-embyserver
    allanpk716-chinesesubfinder
    zfl666-cloudflare-bestip
    p3terx-aria2-pro
    p3terx-ariang
    p3terx-tele-aria2
    rclone-rclone
    whyour-qinglong
    superng6-qbittorrentee
)
for dir in ${docker_dir[*]}; do
    echo ${dir}
    cd ${dir}
    docker-compose down &&
        docker-compose up -d
    cd ..
done
