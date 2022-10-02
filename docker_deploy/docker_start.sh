container_start_sequence=(
    clouddrive
    radarr
    sonarr
    embyserver
    chinesesubfinder
)
echo '------------------------------------------------'
echo "清理挂载目录"
docker stop clouddrive &&
    sleep 5s &&
    rm /mnt/mergerfs/clouddrive/mounts/CloudDrive/CloudDrive/115网盘 -rf &&
    echo "清理完成"
for container in ${container_start_sequence[*]}; do
    echo '------------------------------------------------'
    echo "启动容器${container}"
    docker restart ${container}
    sleep 15s
    echo "容器启动完成"
    echo '------------------------------------------------'
done
