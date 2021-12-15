# 更新所有容器
sudo apt update &&
    sudo apt upgrade -y &&
    for dir in $(ls .); do
        if
            [[ -d $dir &&
                $dir != "acme" && $dir != "owncloud" && $dir != "html" && $dir != "cert" ]]
        then
            echo $dir &&
                cd $dir &&
                docker-compose down &&
                docker-compose up -d &&
                cd ..
        fi
    done
