#!/bin/bash

sudo yum -y update
mkdir scripts && mv *.sh ./scripts

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

#계정생성
	adduser wsql
	useradd -M mysql #home 폴더 없이 생성.
