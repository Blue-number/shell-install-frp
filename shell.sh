#! /bin/bash 

#  download  and check
#url="https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz"
#
#wget=`apt install wget`
#echo $wget 
#echo "-----------------------------------------------------------------------------------------------------------------------------"
#install=`wget $url`
#echo $install
#echo "frp download!!"
#tar=`tar zxvf frp_0.33.0_linux_amd64.tar.gz`
#echo $tar
#indir=`cd frp_0.33.0_linux_amd64`
#echo $indir
#if [ -d "/systemd" ]; then
#    echo "you are success"
#else
#    exit 1
#fi
#! /bin/bash 
url="https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz"
frp=`wget $url`
tar=`tar zxvf  $PWD/frp_0.48.0_linux_amd64.tar.gz`
infrp=`cd $PWD/frp_0.48.0_linux_amd64`
echo -e "\033[33m $PWD  \033[0"

# check  /etc/frp dictionary alive, not or mkdir
echo "------mkdir /etc/frp dictionart------"

FILE="/etc/frp"
if [ -d "$FILE" ]; then 
    echo "$FILE exits"
else 
    mkdir -p  ${FILE}
fi
echo " /etc/frp dictionary is mkdir finished!!"


#check /etc/frp/  is  empty or full 
count=`ls $FILE|wc -w`
echo $count
if [ $count -ne 0 ]; then
    echo "$FILE not empty"
else
    echo "$FILE is empty"
fi


# copy  and start
echo "------begin fiind frps.ini------"
echo "your current dictionary: $PWD"
target_dir="/etc/frp/"
target_file=`find $PWD  -name frps.ini -printf '%f\n'`

#echo -e "\033[32m ♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦♦ \033[0m"

echo -e "\033[33m  $target_file \033[0m"
echo
echo "you found it"
echo "------begin copy to /etc/frp/------"
copy=`cp -R $target_file $target_dir`
echo $copt
echo "frps.ini  finished"

echo "------begin find frps.service------"
target_file2=`find $PWD -name frps.service -printf '%f\n'`
echo $target_file2
echo
echo "you found it"
echo  "------begin copy to /usr/lib/systemd/system/------"
system="/usr/lib/systemd/system/"
copy2=`cp -R  systemd/$target_file2 $system`
echo "frps.service finished"

echo "------start frps service------"
init=`systemctl daemon-reload`
start1=`systemctl start frps`
echo "task finished!!"
echo $init
echo $start1
