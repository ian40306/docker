FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
MAINTAINER Ian wang <s10482001@gm2.nutn.edu.tw>
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade
RUN echo "root:12345678" | chpasswd
RUN apt-get install -y openssh-server python3 python3-pip vim wget git libcupti-dev iputils-ping curl
RUN echo "PermitRootLogin yes">>/etc/ssh/sshd_config
RUN /etc/init.d/ssh restart
RUN apt-get install -y dbus-x11
RUN echo "X11Forwarding yes">> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no">> /etc/ssh/sshd_config
RUN grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
RUN echo "service ssh start">>~/.bashrc
RUN service ssh start
