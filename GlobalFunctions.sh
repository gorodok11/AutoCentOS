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
