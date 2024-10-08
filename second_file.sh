2. For Loop C Syntax:

#!/bin/bash

for i in $*
do
    for ((n=$i, fact=1; n>1; n--))
    do
        fact=$(($fact * $n))
    done

    echo "The factorial of $i is $fact"
done

3. For Loop Seq Command

#!/bin/bash

for i in $*
do
    fact=1
    for n in $(seq $i -1 2)
    do
        fact=$(($fact * $n))
    done

    echo "The factorial of $i is $fact"
done

(or)

#!/bin/bash

for i in $*
do
    fact=1
    for n in $(seq 2 $i)
    do
        fact=$(($fact * $n))
    done

    echo "The factorial of $i is $fact"
done
--------------------------------------------------------------------------------------------------------------
Assignment: 
1. Assignment: Script to print the number of words, character along with the line numbers

Input:
We are learning Shell Script on Redhat EC2 Instance
We are using AWS Cloud Provider
We are part of September 2024 Devops Batch

Output:
1: 9 52
2: 6 30
3: 8 45

2. Script to find the sum of odd and even numbers passed as arguments to the script

Input: bash sumofoddeven.sh 2 9 4 1 6 5

Output:
The sum of even numbers is 10
The sum of odd numbers is 15
--------------------------------------------------------------------------------------------------------------
Example: Script to check whether a particular set of services are running on the server. [docker, jenkins, ansible]

#!/bin/bash

services="sshd tomcat jenkins ansible docker"

for i in $services
do
    systemctl is-active -q $i
    if [ $? -ne 0 ]; then
        sudo systemctl start $i > /dev/null 2>&1
        echo "!!!!!! Service $i is Stopped - Please Verify"
    fi
done

(or)

#!/bin/bash

services="sshd tomcat jenkins ansible docker"

for i in $services
do
    systemctl is-active -q $i
    if [ $? -ne 0 ]; then
        sudo systemctl start $i > /dev/null 2>&1
        echo "!!!!!! Service $i is Stopped - Please Verify" >> stopped.txt
    fi
done

if [ -e stopped.txt ]; then
    mail -s "Some Service are not running !!!!" adithya@gmail.com < stopped.txt
    rm stopped.txt
fi
--------------------------------------------------------------------------------------------------------------
Example: Script to check the disk usage percentage of the server

#!/bin/bash

disk=`df -h | awk '{print$5}' | sed -n 5p | sed 's/%//g'`
ip=`curl -s ifconfig.me`

if [ $disk -gt 80 ]; then
    echo "!!!The disk usage has crossed 80% on the server $ip" 
fi

(or)

#!/bin/bash

disk=`df -h | awk '{print$5}' | sed -n 5p | sed 's/%//g'`
ip=`curl ifconfig.me`

if [ $disk -gt 80 ]; then
    echo "!!!The disk usage has crossed 80% on the server $ip" | mail -s "Disk Full" adithya@gmail.com
fi
--------------------------------------------------------------------------------------------------------------
Crontab

A cronjob is a linux service used for scheduling commands to be executed periodically

crontab -e --> To edit the crontab file
crontab -l --> To list the existing crontabs

*       *       *       *       *       <command>
mins    hour    date    month   day

Sunday      --      00
Monday      --      01
Tuesday     --      02
Wednesday   --      03
Thursday    --      04
Friday      --      05
Saturday    --      06

6 PM on 4th Oct on Friday           --      00 18 04 10 05 <command>
Every Friday at 9 AM                --      00 09 * * 05 <command>
Every Hour at 30th Minute           --      30 * * * * <command>
Every 30 Minutes                    --      */30 * * * * <command>
Every Minute                        --      * * * * * <command>
9 AM from Monday to Friday          --      00 09 * * 01-05 <command>
6PM on Monday and Friday            --      00 18 * * 01,05 <command>

For Practise - crontab.guru
--------------------------------------------------------------------------------------------------------------
Case Statement:

Syntax:

case $<var> in
pattern1) Commands to be executed if variable matches pattern1;;
pattern2) Commands to be executed if variable matches pattern2;;
pattern3) Commands to be executed if variable matches pattern3;;
pattern4 | pattern5) Commands to be executed if variable matches either pattern4 or pattern5;;
*) Commands to be executed if none of the above patterns match;;
esac

Example: Script using case stament to check the number entered by the user

1. IF Condition:

#!/bin/bash

echo "Please enter a number between 1 to 5"
read n

if [ $n -eq 1 ]; then
    echo "The number entered by the user is 1"
elif [ $n -eq 2 ]; then
    echo "The number entered by the user is 2"
elif [ $n -eq 3 ]; then
    echo "The number entered by the user is 3"
elif [ $n -eq 4 ] || [ $n -eq 5 ]; then
    echo "The number entered by the user is 4 or 5"
else 
    echo "Invalid Input"
fi

2. Case Statement:

#!/bin/bash

echo "Please enter a number between 1 to 5"
read n

case $n in
1) echo "The number entered by the user is 1";;
2) echo "The number entered by the user is 2";;
3) echo "The number entered by the user is 3";;
4|5) echo "The number entered by the user is 4 or 5";;
*) echo "invalid Input"
esac
--------------------------------------------------------------------------------------------------------------
Example: Script using case statement create a menu based operation for the below list

1 -- Create an user
2 -- Add an user to a group
3 -- Search a file
4 -- Create a softlink

#!/bin/bash

echo -e "Welcome to the server, These are the options available with this script\n"
echo "1 -- Create an user"
echo "2 -- Add an user to a group"
echo "3 -- Search a file"
echo "4 -- Create a softlink"
echo "5 -- Create a hardlink"

echo -e "\n\nPlease select an option"
read opt

case $opt in
1) echo -e "\nOption to create an user has been selected"
echo "Enter the username"
read user
sudo useradd $user
echo -e "\nUser $user has been created successfully"
;;
2) echo -e "\nOption to add an user to a group has been selected"
echo "Enter the username"
read user
echo "Enter the group"
read group
sudo gpasswd -a $user $group
;;
3) echo -e "\nOption to search for a file has been selected"
echo "Enter the file name"
read file
find -type f -name $file
;;
4) echo -e "\nOption to create a softlink has been selected"
echo "Enter the original file path"
read file
echo "Enter the softlink path"
read softlink
ln -s $file $softlink
;;
5) echo -e "\nOption to create a hardlink has been selected"
echo "Enter the original file path"
read file
echo "Enter the hardlink path"
read hardlink
ln $file $hardlink
;;
*) echo -e "\nInvalid Input, Please rerun the script and select the appropriate option"
;;
esac
--------------------------------------------------------------------------------------------------------------
Functions:

Syntax:

<function-name> () {
    commands
}
--------------------------------------------------------------------------------------------------------------
Example: Hello World Script

#!/bin/bash

hello () {
    echo "Hello World"
    echo "This is abc, from Bengaluru"
    echo "I am learning Shell Script"
