apt-get update
apt-get install -y openssh-server
echo "PermitRootLogin yes">>/etc/ssh/sshd_config
/etc/init.d/ssh restart
passwd