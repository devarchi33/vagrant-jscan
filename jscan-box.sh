#!/bin/bash

sudo yum update
mkdir scripts && mv *.sh ./scripts
#Timezone 설정 및 시간동기화.
sudo yum install -y rdate
