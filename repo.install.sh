#!/bin/bash
#Установка дополнительных источников ПО
#EPEL, REMI, RPMForge,
cd /tmp
echo "Установка источника ПО EPEL для необходимых пакетов."
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
rm epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6.rpm
rm remi-release-6.rpm
wget http://dl.atrpms.net/all/atrpms-repo-6-6.el6.x86_64.rpm
rpm -Uvh atrpms-repo-6-6.el6.x86_64.rpm
rm atrpms-repo-6-6.el6.x86_64.rpm
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
rpm -Uvh rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
rm rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
#Активация источников REMI
sed -i "/\[remi\]/,/\[.*\]/s/enabled=.*/enabled=1/" /etc/yum.repos.d/remi.repo
echo "=================================================="
