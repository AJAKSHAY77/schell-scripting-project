#!/bin/bash

#script should be execute with sudo/root access.

if [[ $UID -ne 0 ]]
then

     echo "Please run with sudo or root."
     exit 1
fi


#user should provide atleat one argument as username else guide him

if [[ $# -lt 1 ]]
then
   echo "Usage: ${0} user_name [COMMENT]..."
   echo "create  a user with name User_name and comments field of COMMENT"
   exit 1

fi


#store first argument as username

User_name=$1

#echo $User_name

#In case of more then one argument ,store it as account comments

shift
COMMENT=$@

#echo $COMMENT


# create a password
PASSWORD=$(date +%s%N)

#echo $PASSWORD


#create user

useradd -c "$COMMENT" -m $User_name


#check if  user is successfully created or not

if [[ $? -ne 0  ]]
then
   echo "user cannot be created"
   exit 1
fi


#set the password for the user

#echo $PASSWORD | passwd --stdin $User_name
echo "$User_name:$PASSWORD" | chpasswd

#check if password is successfully set or not
if [[ $? -ne 0  ]]
then
   echo "password could not be set"
   exit 1
fi


#Force  password change on first  login

passwd -e $User_name

#display  the username ,password and the host where it is created

echo 

echo "username : $User_name"

echo

echo "password : $PASSWORD"

echo

echo "hostname : $(hostname)"


