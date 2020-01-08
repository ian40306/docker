apt-get update
apt-get install -y openssh-server
echo "PermitRootLogin yes">>/etc/ssh/sshd_config
echo "/etc/init.d/ssh start">>~/.bashrc
/etc/init.d/ssh restart
echo ""
echo "Please enter the ssh password"
echo ""
passwd
systemctl enable ssh
