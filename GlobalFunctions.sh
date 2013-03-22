#!/bin/bash
#Функция для легкого использования программы yum.
install_packages()
{
	echo "Установка пакетов: ${@}"
	yum -y update && yum -y install ${@}
	if [ $? -eq 0 ]; then
		echo "Пакет успешно установлен."
	else
		echo "Не удалось установить пакет!"
		exit 1
	fi
}

#Функция для проаерки подключения к интернету
ping_google()
{
echo "Проверка подключения к интернету (ping google.com)"
ping google.com -c1 2>&1 >> /dev/null
if [ $? -eq 0 ]; then
	echo "Есть подключение!"
else
	echo "При проверке связи не удалось обнаружить узел www.google.com."
	
	exit 1
fi
}
