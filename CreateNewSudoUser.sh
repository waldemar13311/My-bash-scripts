#!/bin/bash

# Данный скрипт в интерактивном режиме создаёт пользователя
# с паролем и добавляет его в группу wheel

unset NAME
unset PASSWORD
unset CHARCOUNT


# Спрашиваем имя
read -p "Enter new user's name: " NAME

# Спрашиваем пароль
echo -n "Enter password: "

# Код ниже нужен для того, чтобы были звёздочки при вводе
stty -echo

CHARCOUNT=0
while IFS= read -p "$PROMPT" -r -s -n 1 CHAR
do
    # Enter - accept password
    if [[ $CHAR == $'\0' ]] ; then
        break
    fi
    # Backspace
    if [[ $CHAR == $'\177' ]] ; then
        if [ $CHARCOUNT -gt 0 ] ; then
            CHARCOUNT=$((CHARCOUNT-1))
            PROMPT=$'\b \b'
            PASSWORD="${PASSWORD%?}"
        else
            PROMPT=''
        fi
    else
        CHARCOUNT=$((CHARCOUNT+1))
        PROMPT='*'
        PASSWORD+="$CHAR"
    fi
done

stty echo
echo $'\n'


useradd -m $NAME -s /bin/bash -G wheel -p $(perl -e 'print crypt($ARGV[0], "password")' $PASSWORD)
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers.d/%wheel
chmod 644 /etc/sudoers.d/%wheel

echo 'Done'