#!/bin/bash
# TODO: add more than one users

if [ -f /etc/deepin-installer.conf ];then
    . /etc/deepin-installer.conf
fi

[ -z ${DI_USERNAME} ] && exit 101
[ -z ${DI_PASSWORD} ] && exit 101
[ -z ${DI_HOSTNAME} ] && DI_HOSTNAME="deepin"

useradd -U -m --skel /etc/skel --shell /bin/bash ${DI_USERNAME}
echo "${DI_USERNAME}:${DI_PASSWORD}" | chpasswd
gpasswd -a ${DI_USERNAME} users
gpasswd -a ${DI_USERNAME} cdrom
gpasswd -a ${DI_USERNAME} floppy
gpasswd -a ${DI_USERNAME} audio
gpasswd -a ${DI_USERNAME} video
gpasswd -a ${DI_USERNAME} plugdev
gpasswd -a ${DI_USERNAME} sambashare
gpasswd -a ${DI_USERNAME} adm
gpasswd -a ${DI_USERNAME} wheel
gpasswd -a ${DI_USERNAME} lp
gpasswd -a ${DI_USERNAME} netdev
gpasswd -a ${DI_USERNAME} scanner
gpasswd -a ${DI_USERNAME} lpadmin
gpasswd -a ${DI_USERNAME} sudo
gpasswd -a ${DI_USERNAME} storage
gpasswd -a ${DI_USERNAME} network

chown -hR ${DI_USERNAME}:${DI_USERNAME} /home/${DI_USERNAME}

echo "${DI_HOSTNAME}" | tee /etc/hostname


HOSTS_CONTENTS="127.0.0.1	localhost
127.0.1.1   ${DI_HOSTNAME}

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
"
echo ${HOSTS_CONTENTS} | tee /etc/hosts

