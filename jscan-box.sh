#!/bin/bash

sudo yum -y update

#엔터프라이즈 추가 패키지 설치.
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
 	sudo rpm -Uvh epel-release-latest-6.noarch.rpm
 	sudo yum -y install libmcrypt-devel #php-mcrypt module 설치.

#php compile 관련 패키지 설치.
	sudo yum install -y libjpeg-devel
	sudo yum install -y libpng-devel

#64bit에서만 link 걸기.
	ln -s /usr/lib64/libjpeg.so /usr/lib/
	ln -s /usr/lib64/libpng.so /usr/lib/

#Timezone 설정 및 시간동기화.
 	ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
 	sudo yum install -y rdate
 	rdate -s time.bora.net && clock –w

#계정생성.
	adduser wsql
	useradd -M mysql #home 폴더 없이 생성.

#J-Scan 사전 설치 모듈 다운로드.
	sudo yum -y install unzip
	wget https://s3-ap-northeast-1.amazonaws.com/devarchi33-jscan/J-Scan-PreInstall.zip
	unzip J-Scan-PreInstall.zip
	sudo tar xvfz mysql-5.6.14.tar.gz
	sudo chown -R root:root mysql-5.6.14/
	sudo tar xvfz httpd-2.4.6.tar.gz
	sudo chown -R root:root httpd-2.4.6/
	sudo tar xvfz php-5.5.5.tar.gz
	sudo chown -R root:root php-5.5.5/
	sudo tar xvfz apr-1.4.8.tar.gz
	sudo chown -R root:root apr-1.4.8/
	sudo tar xvfz apr-util-1.5.2.tar.gz
	sudo chown -R root:root apr-util-1.5.2/

#파일 정리.
	mkdir setup && mv *.tar.gz ./setup && rm -rf *.zip && mv *.rpm ./setup
	mkdir scripts && mv *.sh ./scripts

#MySQL 설치.
	#Build
	sudo yum -y install cmake
	sudo yum -y install gcc gcc-c++ autoconf automake zlib* fiex* libxml* ncurses-devel libmcrypt* libtool-ltdl-devel* cmake cmake-gui libaio-devel bison-devel make
	cd mysql-5.6.14 && sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all -DMYSQL_DATADIR=/home/data  -DENABLED_LOCAL_INFILE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.socket && sudo make all && sudo make install
	
	#Etc
	sudo chown -R mysql.mysql /usr/local/mysql
	sudo mkdir /home/data
	sudo chown -R mysql.mysql /home/data
	cd /usr/local/mysql && sudo /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/home/data
   	sudo cp /vagrant/my.cnf-script.txt /usr/local/mysql/my.cnf  //스크립트만 사용시 /vagrant/ 제거하기.
	sudo cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
	sudo /etc/init.d/mysqld start
