# ubuntu1804相關使用方式
## 密碼設定
passwd
## jupyter notebook密碼設定
jupyter notebook password
## 安裝git
$apt-get update  
$apt-get upgrade  
$apt-get install git
## 下載相關安裝檔
$git clone https://github.com/ian40306/docker.git
## 安裝ssh
$source ~/docker/ubuntu1804/ssh_setup.sh  
使用後要輸入ssh所需密碼  
## 使用ssh登入
EX:$ssh -p 52022 root@IP
## 安裝tensorflow2-GPU
$source ~/docker/ubuntu1804/tf_make.sh  
使用後要入jupyter notebook所需密碼
## 開啟jupyter notebook
$jupyter notebook --ip=0.0.0.0 --allow-root
## 指定GPU
CUDA_VISIBLE_DEVICES=(number)  
number為第幾張GPU
## 使用 screen 讓指令在後台繼續執行
安裝  
$sudo apt install screen -y  
查詢screen使用狀況  
$screen -ls  
切換screen介面  
$screen -x (number)  
## 安裝pytorch1.0.0
$pip install torch==1.0.0 torchvision==0.2.1  
查詢版本:  
python3 -c "import torch;print('Your pytorch version is:');print(torch.__version__);"  
備註:version前後要加兩個底線_
## 安裝jupyter lab
$pip install jupyterlab  
/root/.jupyter/jupyter_notebook_config.py 新增c.NotebookApp.terminado_settings = { 'shell_command': ['bash'] }  
開啟:  
$CUDA_VISIBLE_DEVICES=1 jupyter lab --ip=0.0.0.0 --allow-root 
## 確認GPU是否支援
tensorflow:  
$python3 -c "import tensorflow as tf;print('Can your tensorflow use GPU?');print(tf.test.is_gpu_available());"  
pytorch:  
$python3 -c "import torch as t;print('Can your pytorch use GPU?');print(t.cuda.is_available());"  
## 安裝Anaconda
$wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh  
$sh Anaconda3-2020.02-Linux-x86_64.sh  
$export PATH=~/anaconda3/bin:$PATH  
## 登入看見一些相關資訊
$sudo apt install -y landscape-common  
手動看訊息:  
$landscape-sysinfo
## 資料大小查詢
$du -d 1 -h  
## ubuntu 硬碟掛載相關
/dev 下面所有的硬碟情況  
ls /dev/[sh]d*  
安裝程式:  
$sudo apt-get install parted  
開啟程式:  
$sudo parted  
切換硬碟:  
(parted)select /dev/sdb  
印出硬碟資訊:  
(parted)print  
磁碟分割:  
(parted)mklabel gpt  
確認無誤之後按y  
建立磁碟分割區大小資訊:  
(parted)mkpart (name) 0.00TB 3.00TB  
檢查建立是否正確:  
(parted)print  
離開parted:  
(parted)quit  
將新分割區格式化:  
$sudo mkfs.ext4 /dev/sdb1  
查詢硬碟之UUID:  
$sudo blkid  
掛載:  
$mkdir /data  
$mount /dev/sdb1 /data  
$echo "UUID=4c025e0d-0303-4ba5-9b46-cdb4fc170926 /data          ext4    defaults        0       2" >> /etc/fstab  
### 使用lvm技術:  
[硬碟部分](http://linux.vbird.org/linux_basic/0230filesystem.php#gdisk "link"):  
卸載要使用的硬碟(要格式化硬碟再做):  
$umount (dir)  
切割欲使用硬碟:  
$sudo gdisk /dev/sda  
查看硬碟資訊:  
$p  
刪除硬碟內分割槽:  
$d  
新增分割槽:  
$n  
1 enter  
2 enter  
3 enter  
4 8E00  
說明:  
1 硬碟第幾位元做切割(1-128)  
2 硬碟起始位置  
3 硬碟終位置  
4 格式  
儲存並離開:  
$w  
[LVM部分](http://linux.vbird.org/linux_basic/0420quota.php#LVM "link"):  
安裝LVM:  
$sudo apt-get install lvm2 -y  
1.pv階段:  
| 指令 | 說明 |  
|:---:|:---:|  
| pvcreate | 將實體 partition 建立成為 PV |  
| pvscan | 搜尋目前系統裡面任何具有 PV 的磁碟 |  
| pvdisplay | 顯示出目前系統上面的 PV 狀態 |  
| pvremove | 將 PV 屬性移除，讓該 partition 不具有 PV 屬性 |  
  
EX:  
查詢pv:  
$sudo pvscan  
創立pv:  
$sudo pvcreate /dev/sda1  
2.VG 階段:  
| 指令 | 說明 |  
|:---:|:---:|  
| vgcreate | 建立 VG |  
| vgscan | 搜尋系統上面是否有 VG 存在 |  
| vgdisplay | 顯示目前系統上面的 VG 狀態 |  
| vgextend | 在 VG 內增加額外的 PV |  
| vgreduce | 在 VG 內移除 PV |  
| vgchange | 設定 VG 是否啟動 (active) |  
| vgremove | 刪除一個 VG |  
  
EX:  
創立vg:  
$sudo vgcreate (vg-name) /dev/sda1  
增加vg容量:  
$sudo vgextend (vg-name) /dev/sda2  
查詢vg:  
$sudo vgscan  
3.LV 階段  
| 指令 | 說明 |  
|:---:|:---:|  
| lvcreate | 建立 LV |  
| lvscan | 查詢系統上面的 LV |  
| lvdisplay | 顯示系統上面的 LV 狀態 |  
| lvextend | 在 LV 裡面增加容量 |  
| lvreduce | 在 LV 裡面減少容量 |  
| lvremove | 刪除一個 LV |  
| lvresize | 對 LV 進行容量大小的調整 |  
  
EX:  
新增lv:  
$sudo lvcreate -L 2G -n (lv-name) (vg-name)  
查詢lv:  
$sudo lvscan  
增大lv容量:  
要先新增pv以及vg  
$sudo lvresize -L +500M /dev/(vg-name)/(lv-name)  
或是  
$sudo lvresize -l +100%FREE /dev/(vg-name)/(lv-name)  
$resize2fs /dev/(vg-name)/(lv-name)  
4.檔案系統階段  
格式化:  
$sudo mkfs.ext4 /dev/(vg-name)/(lv-name)  
創立欲儲存資料夾:  
$sudo mkdir (dir)  
掛載:  
$sudo mount /dev/(vg-name)/(lv-name) (dir)  
開機掛載:  
vim /etc/fstab  
新增以下:  
/dev/(vg-name)/(lv-name) /data ext4 defaults 0 2
## 資料夾底下有多少資料
$find . -name "*.jpg" -type f |wc -l
## 複製大量資料(test to train)
$find test/ -name "*.jpg" | xargs -i cp {} train
## 當前路徑中所有目錄所佔用大小做統計並且排序
$du -chd 1 | sort -h
## 下載google drive檔案
$wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=[ID]' -O Filename  
-r 為資料夾(壓縮檔)，ID為google drive提供，Filename要與原檔案符合
## 顯示terminal print
利用python執行x.py 並將print存到output.log中  
$python x.py > output.log  
隨時監視terminal print  
$tail -f output.log
## python 去掉warning
在程式碼中加入下面兩行:  
import warnings  
warnings.filterwarnings("ignore")
## 壓縮/解壓縮
### tar
$tar cvf FileName.tar DirName  
$tar xvf FileName.tar
### zip
$zip -r FileName.zip DirName  
$unzip FileName.zip
