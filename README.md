# DOCKER  
## 安裝nvidia driver
$sudo apt-get install gcc -y  
$sudo apt-get install make  
$sudo service gdm3 stop  
$sudo reboot  
  
$sudo add-apt-repository ppa:graphics-drivers/ppa  
$sudo apt-get update  
$ubuntu-drivers devices  
$sudo apt-get install nvidia-driver-<VERSION_STRING>  
$sudo service gdm3 start  
$sudo reboot  
註:<VERSION_STRING>版本請依照所需  
### 驗證安裝
$nvidia-smi  
### 其他驗證
$cat /usr/local/cuda/version.txt  
$nvcc -V  
$cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2  
or  
$cat /usr/include/cudnn.h | grep CUDNN_MAJOR -A 2  
註:若失敗則重安裝
## 安裝docker
$sudo apt-get update  
$sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y  
$curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  
$sudo apt-key fingerprint 0EBFCD88  
$sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"  
$sudo apt-get update  
$sudo apt-get install docker-ce docker-ce-cli containerd.io -y  
$apt-cache madison docker-ce  
$sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io  
註:<VERSION_STRING>版本請依照所需  
EX: sudo apt-get install docker-ce=5:19.03.5\~3-0\~ubuntu-bionic docker-ce-cli=5:19.03.5\~3-0\~ubuntu-bionic containerd.io  
  
$distribution=$(. /etc/os-release;echo $ID$VERSION_ID)  
$curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -  
$curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list  
$sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit  
$sudo systemctl restart docker
## 創建container  
創完會以root身分登入  
$sudo docker run --gpus all -it --name (NAME) --shm-size 1G --ipc=host -p (B):22 -p (A):8888 -p (C):6006 (image)  
  
NAME、A、B、C為自取(將NAME取代成想要的名子，A取代為想要的port(不是改8888))  
A為開啟jupyter notebook的port  
B為遠端ssh 的port
C為開啟tensorboard的port  
image請從下方表格選擇  
  
| image name | 安裝的程式 | 說明 |  
|:---:|:---:|:---:|  
| nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04 | cuda10.0、cudnn7、ubuntu18.04 | 基本ubuntu18，且已安裝cuda10、cudnn7 |  
| nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 | cuda10.0、cudnn7、ubuntu16.04 | 基本ubuntu16，且已安裝cuda10、cudnn7 |  
| ian40306/u18_nvidia_x11_basic | cuda10.0、cudnn7.6.0、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl、dbus-x11 | 基本ubuntu18，且已安裝cuda10、cudnn7.6.0、ssh遠端以及一些基本程式(ssh密碼為12345678，可直接遠端) |  
| ian40306/cuda10.0-cudnn7-devel-ubuntu18.04 | cuda10.0、cudnn7.6.0、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl | ubuntu18，安裝cuda10、cudnn7.6.0、並加上ssh遠端以及一些基本程式(ssh登入前須設定密碼) |  
| ian40306/cuda10.0-cudnn7-devel-ubuntu18.04-tf1.14.0 | cuda10.0、cudnn7.6.0、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl、tensorflow-gpu1.14、jupyter、matplotlib、pillow、lxml、pandas、Cython、opencv-python、openpyxl | ubuntu18，安裝cuda10、cudnn7.6.0、ssh遠端以及一些基本程式(ssh登入前須設定密碼)、tensorflow14.0以及一些相關python函式庫、jupyter notebook(登入後須設定密碼) |  
| ian40306/ubuntu18.04-nvidia-x11-tf1.14 | cuda10.0、cudnn7.6.0、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl、tensorflow-gpu1.14、jupyter、matplotlib、pillow、lxml、pandas、Cython、opencv-python、openpyxl、dbus-x11、firefox | ubuntu18，安裝cuda10、cudnn7.6.0、ssh遠端以及一些基本程式(ssh密碼為12345678，可直接遠端)、tensorflow14.0以及一些相關python函式庫、jupyter notebook(登入後須設定密碼)、使用mobaxterm可叫出畫面 |  
| ian40306/ubuntu18.04-nvidia-x11-tf2 | cuda10.0、cudnn7.6.0、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl、tensorflow-gpu2、jupyter、matplotlib、pillow、lxml、pandas、Cython、opencv-python、openpyxl、dbus-x11、firefox | ubuntu18，安裝cuda10、cudnn7.6.0、ssh遠端以及一些基本程式(ssh密碼為12345678，可直接遠端)、tensorflow2以及一些相關python函式庫、jupyter notebook(登入後須設定密碼)、使用mobaxterm可叫出畫面 |  
| ian40306/u18-n10.0-c7.6.5-tf1.15.0-x11 | cuda10.0、cudnn7.6.5、ubuntu18.04、openssh-server、python3、python3-pip、vim、wget、git、libcupti-dev、iputils-ping、curl、tensorflow-gpu1.15、jupyter、matplotlib、pillow、lxml、pandas、Cython、opencv-python、openpyxl、dbus-x11、firefox、screen | ubuntu18，安裝cuda10、cudnn7.6.5、ssh遠端以及一些基本程式(ssh密碼為12345678，可直接遠端)、tensorflow1.15以及一些相關python函式庫、jupyter notebook(登入後須設定密碼)、使用mobaxterm可叫出畫面、可使用screen |  
  
EX:sudo docker run --gpus all -it --name test --shm-size 1G --ipc=host -p 50000:22 -p 50050:8888 -p 50051:6006 ian40306/u18-n10.0-c7.6.5-tf1.15.0-x11  
相關使用方式請至[ubuntu1804](https://github.com/ian40306/docker/tree/master/ubuntu1804 "link")查詢  
推薦:  
ian40306/u18-n10.0-c7.6.5-x11-basic  
ian40306/u18-n10.0-c7.6.5-tf1.15.0-x11
## 啟動container  
$sudo docker start -i (NAME)
## 結束container  
$exit
## 資料傳輸
使用filezilla
## 遠端程式
使用vscode 或者 mobaxterm
## docker file
註:需先申請docker hub帳號  
### 建立dockerfile
$mkdir docker-test && cd docker-test  
### 編輯dockerfile
$vim Dockerfile  
EX: 請參考docker_file/ian40306_cuda10.0-cudnn7-devel-ubuntu18.04_basic/Dockerfile   
指令介紹:  
  
FROM：使用到的 Docker Image 名稱  
MAINTAINER： 用來說明，撰寫和維護這個 Dockerfile 的人是誰，也可以給 E-mail的資訊  
RUN： RUN 指令後面放 Linux 指令，用來執行安裝和設定這個 Image 需要的東西  
ADD： 把 Local 的檔案複製到 Image 裡，如果是 tar.gz 檔複製進去 Image 時會順便自動解壓縮。  
ENV： 用來設定環境變數  
CMD： 在指行 docker run 的指令時會直接呼叫開啟 Tomcat Service  
### 把 Docker Image Push 到 Docker Hub 裡
$sudo docker build -t="your-name/image-name" . --no-cache  
$sudo docker login  
$sudo docker push your-name/image-name  
### 更改docker儲存位置
$sudo vim /lib/systemd/system/docker.service  
將14行改成如下(目標資料夾為/home/docker)  
ExecStart=/usr/bin/dockerd --data-root /home/docker -s overlay2 -H fd:// --containerd=/run/containerd/containerd.sock  
ExecReload=/bin/kill -s HUP $MAINPID  
儲存後輸入:  
$sudo systemctl daemon-reload  
$sudo service docker restart  
## ubuntu18.04
相關使用方式移至[ubuntu1804](https://github.com/ian40306/docker/tree/master/ubuntu1804 "link")
