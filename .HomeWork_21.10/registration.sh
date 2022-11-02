#!/bin/bash
exec 2>./.HomeWork_21.10/reg_errors
while true
do
    end_flag=0
    echo "Придумайте логин: "
    read user_login
    if [[ $user_login == 0 ]]
    then
        echo ""
        ./hw_21_10.sh
        break
    fi
    user_login_len=${#user_login}
    if [[ $user_login_len -lt 4 ]]
    then
        echo "Слишком короткий логин, не меньше 4 символов!"
        echo "Пользователь ввёл логин, длина которого меньше 4! -- $user_login" >&2
    else
        flag=0
        while read login
        do 
            if [[ $user_login == $login ]]
            then 
                flag=1
            fi
        done < ./.HomeWork_21.10/database
        if [[ $flag == 0 ]]
        then   
            while true
            do 
                echo "Придумайте пароль: "
                read -s user_password
                if [[ $user_password == 0 ]]
                then
                    echo ""
                    ./hw_21_10.sh
                    break
                fi
                user_password_len=${#user_password}
                if [[ user_password_len -lt 6 ]]
                then
                    echo "Пароль слишком лёгкий, не меньше 6 символов"
                    echo "Пользователь ввёл пароль, длина которого меньше 6! -- $user_password" >&2
                else
                    echo "$user_login">>./.HomeWork_21.10/database
                    echo "$user_password" | md5sum>>./.HomeWork_21.10/database
                    echo "Спасибо за печеньки!"
                    end_flag=1
                    break
                fi
            done
        else
            echo "Ох так это вы $user_login, вы уже зарегестрированны"
            echo "Логин $user_login уже существует!" >&2
        fi
    fi
    if [[ end_flag -eq 1 ]]
    then
        echo "Возвращение в меню..."
        sleep 4
        echo ""
        ./hw_21_10.sh
        break
    fi
done
