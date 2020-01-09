FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
MAINTAINER Ian wang <s10482001@gm2.nutn.edu.tw>
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade
RUN apt-get install -y openssh-server python3 python3-pip vim wget git libcupti-dev iputils-ping curl
RUN echo "PermitRootLogin yes">>/etc/ssh/sshd_config
RUN echo "/etc/init.d/ssh start">>~/.bashrc
RUN /etc/init.d/ssh restart
RUN pip3 install tensorflow-gpu==1.14
RUN pip3 install jupyter
RUN jupyter notebook --generate-config
RUN pip3 install matplotlib pillow lxml pandas Cython opencv-python openpyxl
