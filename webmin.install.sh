#!/bin/bash
#WebMin - приложение для облегчения управления сервером через WEB консоль
#Когда Webmin установлен из репозитория, установка исправлений и патчей может быть автоматизирована как и другие системные обновления, 
#и управляться при помощи YUM. Кроме того, демон yum-updates предупредит вас об обновлениях и(или) установит их в зависимости от заданных параметров.
echo "Установка WebMin..."
echo "[Webmin]
name=Webmin Distribution Neutral
baseurl=http://download.webmin.com/download/yum
enabled=1" >/etc/yum.repos.d/webmin.repo
rpm --import http://www.webmin.com/jcameron-key.asc
yum -y install webmin
echo "=================================================="
