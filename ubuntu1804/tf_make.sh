#install python3
apt-get update
apt-get install python3 -y

#install pip
apt update
apt install python3-pip -y
pip3 install --upgrade pip

#install jupyter notebook
pip install jupyter
jupyter notebook --generate-config

#install vim
apt-get install vim -y
#install tensorflow gpu
pip install tensorflow-gpu
python3 -c "import tensorflow as tf; print('Your tensorflow version:'); print(tf.__version__))"

echo ""
echo "Please enter the jupyter notebook password"
echo ""
jupyter notebook password