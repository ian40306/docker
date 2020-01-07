apt-get update
apt-get install -y openssh-server
echo "PermitRootLogin yes">>/etc/ssh/sshd_config
/etc/init.d/ssh restart
echo ""
echo "Please enter the ssh password"
echo ""
passwd
