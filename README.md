# DOCKER  
# 創建contariner  
創完會以root身分登入  
sudo nvidia-docker run -it --name (NAME) -p (B):22 -p (A):8888 nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04  
NAME、A、B為自取(將NAME取代成想要的名子，A取代為想要的port(不是改8888))  
A為開啟jupyter notebook的port  
B為遠端ssh 的port  
# 啟動contariner  
sudo docker start -i (NAME)
# 結束contariner  
exit  
# 其他  
