#!/bin/bash

# Вывод информации о скрипте
echo "Создатель: Цыриторов Цырен гр.739-1"
echo "Название программы: Менеджер паролей"
echo "Описание: Скрипт предназначен для блокировки/разблокировки пользователей в системе"

# Бесконечный цикл
while true; do
    # Запрос имени пользователя
    read -p "Введите имя пользователя (или 'q' для выхода): " username

    # Проверка на выход из цикла
    if [ "$username" == "q" ]; then
        echo "Выход из программы"
        exit 0
    fi

    # Запрос типа действия
    until [ "$action" == "block" ] || [ "$action" == "unblock" ]; do
        read -p "Введите 'block' для блокировки пользователя или 'unblock' для разблокировки: " action
        if [ "$action" != "block" ] && [ "$action" != "unblock" ]; then
            echo "Ошибка: введен неверный тип действия. Повторите ввод."
        fi
    done

    # Блокировка/разблокировка пользователя
    if [ "$action" == "block" ]; then
        sudo passwd -l "$username" 2> /dev/null
        if [ "$?" -eq 0 ]; then
            echo "Пользователь $username успешно заблокирован"
        else
            echo "Ошибка: пользователь $username не был заблокирован" >&2
        fi
    elif [ "$action" == "unblock" ]; then
        sudo passwd -u "$username" 2> /dev/null
        if [ "$?" -eq 0 ]; then
            echo "Пользователь $username успешно разблокирован"
        else
            echo "Ошибка: пользователь $username не был разблокирован" >&2
        fi
    fi

    # Запрос повторения цикла
    until [ "$repeat" == "yes" ] || [ "$repeat" == "no" ]; do
        read -p "Продолжить работу? (yes/no): " repeat
        if [ "$repeat" != "yes" ] && [ "$repeat" != "no" ]; then
            echo "Ошибка: введите 'yes' или 'no'" >&2
        fi
    done

    # Проверка на выход из цикла
    if [ "$repeat" = "no" ]; then
        echo "Выход из программы"
        exit 0
    fi

    # Сброс переменных
    action=""
    repeat=""
done
