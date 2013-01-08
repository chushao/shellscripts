#!/bin/bash
# ntpcheck.sh
# January 7, 2013
# By Chu Shao
# To run, ntpCheck.sh firstNTPServer secondNTPServer
#
# This script was written for unix OS to check if the differences between NTP of servers that are synced to it
#
# Tested on CentOS 6 and Mac OSX

#Querys the differences between the system's time and server's time and saves the offset
NTP1=`ntpdate -q $1 | head -1 | awk '{ print $6 }'`
NTP2=`ntpdate -q $2 | head -1 | awk '{ print $6 }'`
#if theres a , at the end of the number, remove it
if  [[ $NTP1 == *, ]]
then
    NTP1=${NTP1%?}
fi

if [[ $NTP2 == *, ]]
then
    NTP2=${NTP2%?}
fi
#Calculate using bc... because bash doesn't support float point apparently?
NTPDiff=`echo $NTP1 - $NTP2 | bc`
#Compares the two numbers
positiveCompare=`echo "$NTPDiff < 10" | bc`
negativeCompare=`echo "$NTPDiff > -10" | bc`
#If over threshold returns the NTP values and then exits with status 1
if [ $positiveCompare != 1 ] && [ $negativeCompare != 1 ]
then
    echo "The NTP servers are more than 10 seconds off!"
    echo $NTPDiff
    echo "First NTP was: "$NTP1
    echo "Second NTP was: "$NTP2  
    exit 1
fi
#if passed, exit with status 0
exit 0
