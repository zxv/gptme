#!/bin/bash
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null

password=$(head /dev/urandom | tr -dc A-Za-z | head -c 20; echo "")
alias=$(head /dev/urandom | tr -dc A-Za-z | head -c 8; echo "")

echo "root:${password}" | chpasswd
mkdir -p /var/run/sshd

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc && echo "export LD_LIBRARY_PATH" >> /root/.bashrc

/usr/sbin/sshd -D
ssh -o "StrictHostKeyChecking no" -R $alias:22:localhost:22 serveo.net &

echo "Use the following command to connect to the SSH server:"
echo "sshpass -p ${password} ssh -o "StrictHostKeyChecking no" -J serveo.net root@${alias}"
