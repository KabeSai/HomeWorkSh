#!/bin/bash
exec 2>./.HomeWork_21.10/auth_errors
while true
do
    echo ""
    echo "Введите логин: " 
    read user_login
    if [[ $user_login == 0 ]]
    then
        clear
        ./hw_21_10.sh
        break
    fi
    flag=0
    while read login
    do
        if [[ $flag -eq 2 ]]
        then
            password=$login
            flag=1
        fi
        if [[ $user_login == $login ]]
        then
            flag=2
        fi
    done < ./.HomeWork_21.10/database
    if [[ $flag -eq 0 ]]
    then
        echo "Такого логина не существует. Попробуйте ещё раз!"
        echo "Логина: $user_login не существует. Попробуйте ещё раз!">&2
    else
        new_flag=0
        attemption=0
        while [[ $attemption -ne 3 ]]
        do
            echo "Введите пароль: " 
            read -t 10 -s user_password
            if [[ $user_password == 0 ]]
            then
                clear
                ./hw_21_10.sh
                break
            fi
            echo "$user_password" |md5sum >./.HomeWork_21.10/user_pass
            check=0
            while read ps
            do
                check=$ps
            done <./.HomeWork_21.10/user_pass
            if [[ $check == $password ]]
            then
                new_flag=1
            fi
            if [[ $new_flag -eq 1 ]]
            then
                echo 'Вы успешно вошли!'
                clear
                echo "Возвращение в меню..."
                sleep 4
                echo ""
                clear
                ./hw_21_10.sh
                break
            else
                attemption=$(($attemption+1))
                echo "Неверный пароль попыток осталось $((3-$attemption))!"
                echo "Пользователь $user_login ввёл неверный пароль попыток осталось $((3-$attemption))!" >&2
            fi
        done
        if [[ $attemption -eq 3 ]]
        then
            echo "Неуспешная авторизация!"
            echo "Пользователь $user_login не смог авторизироваться!" >&2
        fi
        break
    fi
done