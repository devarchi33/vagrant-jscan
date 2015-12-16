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
	sudo yum -y install cmake
	sudo yum install gcc.x86_64 gcc-c++.x86_64 wget.x86_64 bzip2-devel.x86_64 pkgconfig.x86_64 openssl-devel.x86_64 make.x86_64 man.x86_64 nasm.x86_64 gmp.x86_64 gdbm-devel.x86_64 readline-devel.x86_64 compat-readline43.x86_64 ncurses-devel.x86_64 db4-devel.x86_64 automake* autoconf* -y	
