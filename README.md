# DOCKER  
## 創建contariner  
創完會以root身分登入  
sudo nvidia-docker run -it --name (NAME) -p (B):22 -p (A):8888 nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04  
  
NAME、A、B為自取(將NAME取代成想要的名子，A取代為想要的port(不是改8888))  
A為開啟jupyter notebook的port  
B為遠端ssh 的port  
  
EX:sudo nvidia-docker run -it --name ian -p 52022:22 -p 7500:8888 nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04  
## 啟動contariner  
sudo docker start -i (NAME)
## 結束contariner  
exit
## 資料傳輸
使用filezilla
## ubuntu18.04  
### ssh
#### 安裝ssh
source ~/docker/ubuntu1804/ssh_setup.sh  
使用後要輸入ssh所需密碼  
#### 使用ssh
EX:ssh -p 52022 root@IP
###
