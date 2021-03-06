#!/bin/bash
set -u

GIT_REPO="dalijolijo"
GIT_PROJECT="bitcloud-node-manager"
DOCKER_REPO="dalijolijo"
IMAGE_NAME="bitcloud-node-manager"
IMAGE_TAG="btdx" 
CONFIG_PATH="/home/bitcloud/.bitcloud"
CONFIG=${CONFIG_PATH}/bitcloud.conf
CONTAINER_NAME="bitcloud-node-manager"
RPC_PORT="8330"
BNM_PORT="80"
IP=$(curl -s https://bit-cloud.info/showip.php)

#
# Color definitions
#
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COL='\033[0m'
BTDX_COL='\033[0;36m'

#
# Check if bitcloud.conf already exist.
#
clear
printf "\n${BTDX_COL}DOCKER SETUP FOR BITCLOUD NODE MANAGER${NO_COL}\n"
printf "\nSetup Config file"
printf "\n-----------------\n"

#
# User input: Bitcloud config folder
#
printf "\nPlease define the Bitcloud config folder in which the bitcloud.conf is located. For example /home/bitcloud/.bitcloud\n"
printf "Enter the directory and Hit [ENTER]: "
read CONFIGPATH
CONFIG_PATH=$(echo "${CONFIGPATH}" | xargs)

#
# User input: Bitcloud config folder
#
printf "Is this IP-address $IP your ${BTDX_COL}Bitcloud Masternode${NO_COL} IP-address? [Y/n]: "
read ipaddress
if [[ ("$ipaddress" == "n" || "$ipaddress" == "N") ]]; then
	printf "\nEnter the IP-address of your ${BTDX_COL}Bitcloud Masternode${NO_COL} VPS and Hit [ENTER]: "
	read RPCIP
else
	RPCIP=$(echo $IP)
fi

#
# Docker Installation
#
if ! type "docker" > /dev/null; then
    curl -fsSL https://get.docker.com | sh
fi

#
# Firewall Setup
#
printf "\nDownload needed Helper-Scripts"
printf "\n------------------------------\n"
wget https://github.com/${GIT_REPO}/bitcore-node-manager/raw/master/docker/check_os.sh -O check_os.sh
chmod +x ./check_os.sh
source ./check_os.sh
rm ./check_os.sh
wget https://raw.githubusercontent.com/${GIT_REPO}/${GIT_PROJECT}/master/docker/firewall_config.sh -O firewall_config.sh
chmod +x ./firewall_config.sh
source ./firewall_config.sh ${BNM_PORT} 
rm ./firewall_config.sh

#
# Pull docker images and run the docker container
#
printf "\nStart Docker container"
printf "\n----------------------\n"
sudo docker ps | grep ${CONTAINER_NAME} >/dev/null
if [ $? -eq 0 ];then
    printf "${RED}Conflict! The container name \'${CONTAINER_NAME}\' is already in use.${NO_COL}\n"
    printf "\nDo you want to stop the running container to start the new one?\n"
    printf "Enter [Y]es or [N]o and Hit [ENTER]: "
    read STOP

    if [[ $STOP =~ "Y" ]] || [[ $STOP =~ "y" ]]; then
        docker stop ${CONTAINER_NAME}
    else
	printf "\nDocker Setup Result"
        printf "\n----------------------\n"
        printf "${RED}Canceled the Docker Setup without starting Bitcloud Node Manager Docker Container.${NO_COL}\n\n"
	exit 1
    fi
fi

echo "IP : ${RPCIP}"

docker rm ${CONTAINER_NAME} >/dev/null
docker pull ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
docker run --rm \
 -p ${BNM_PORT}:${BNM_PORT} \
 --name ${CONTAINER_NAME} \
 -e CONFIG_PATH=${CONFIG_PATH} \
 -e RPC_PORT=${RPC_PORT} \
 -e RPCIP=${RPCIP} \
 -v ${CONFIG_PATH}:${CONFIG_PATH} \
 -d ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}

#
# Show result and give user instructions
#
sleep 3
clear
printf "\nDocker Setup Result"
printf "\n----------------------\n"
sudo docker ps | grep ${CONTAINER_NAME} >/dev/null
if [ $? -ne 0 ];then
    printf "${RED}Sorry! Something went wrong. :(${NO_COL}\n"
else
    printf "${GREEN}GREAT! Your ${BTDX_COL}Bitcloud Node Manager${GREEN} Docker Container is running now! :)${NO_COL}\n"
    printf "\nShow your running docker container \'${CONTAINER_NAME}\' with ${GREEN}'docker ps'${NO_COL}\n"
    sudo docker ps | grep ${CONTAINER_NAME}
    printf "\nJump inside the ${BTDX_COL}Bitcloud Node Manager${NO_COL} Docker Container with ${GREEN}'docker exec -it ${CONTAINER_NAME} bash'${NO_COL}\n"
    printf "\nCheck Log Output of ${BTDX_COL}Bitcloud Node Manager${NO_COL} with ${GREEN}'docker logs ${CONTAINER_NAME}'${NO_COL}\n"
    printf "${GREEN}HAVE FUN!${NO_COL}\n\n"
fi
