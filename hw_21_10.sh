#!/bin/bash
while true
do
    echo "Меню" 
    echo ""
    echo "1 - авторизация"
    echo "2 - регистрация"
    echo "0 - завершить программу или вернутся в меню"
    echo "Выберете пункт: "
    read mode
    if [[ $mode -eq 1 ]]
    then
        ./.HomeWork_21.10/authorization.sh
        break
    fi
    if [[ $mode -eq 2 ]]
    then
        ./.HomeWork_21.10/registration.sh
        break
    fi
    if [[ $user_login -eq 0 ]]
    then
        echo "Хорошего дня!"
        break
    fi
done