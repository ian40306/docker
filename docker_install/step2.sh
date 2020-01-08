sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
ubuntu-drivers devices
echo ""
read -p "What VERSION_STRING do you want?: " VERSION_STRING
echo ""
sudo apt-get install nvidia-driver-${VERSION_STRING}
sudo service gdm3 start
sudo reboot