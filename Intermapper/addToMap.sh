#!/bin/bash
# addToMap.sh
# December 17, 2012
# By Chu Shao
# To run, addToMap.sh
#
# This script was written for CentOS images to utilize intermapper remoteaccess
# to automatically populate themselves into an intermapper map. 
# 
# Tested on CentOS 6


# Grabs the Ipaddress of the image to populate into intermapper
# Configs the interface in the next line. Default is eth0
# but can also just take in argument parameters instead of hardcoding
# by using $1, $2 for arg1, arg2.. etc.
interface="eth0"

for line in `ip addr show $interface | grep inet | awk '{ print $2 }' | awk -F "/" '{ print $1 }' | head -1`; do
    ipaddress=$line
done
# Pulls a copy of intermapper remote access jar file from Chu's public files
# most likely need to rewrite the path later on.

curl -O https://dl.dropbox.com/u/7370140/InterMapperRemoteAccess.jar

# create an XML file that takes InterMapper RemoteAccess will import
# currently, it only supports MapName, Address, and defaults on
# using SNMP Traffic as a probe. 
mapName="TestMap"
probe="SNMP Traffic"

touch import.xml
echo "<!-- #format=xml table=devices fields=MapName,MapPath,Address,Probe,SNMPVersion,Community -->" >> import.xml
echo "<devices>" >> import.xml
echo "  <device>" >> import.xml
echo "      <MapName>$mapName</MapName>" >> import.xml
echo "      <MapPath>/$mapName</MapPath>" >> import.xml
echo "      <Address>$ipaddress</Address>" >> import.xml
echo "      <Probe>$probe</Probe>" >> import.xml
echo "      <SNMPVersion>SNMPv2c</SNMPVersion>" >> import.xml
echo "      <Community>AWESOMECOMMUNITYSTRINGHERE</Community>" >> import.xml
echo "  </device>" >> import.xml
echo "</devices>" >> import.xml

# Sends the XML file to Intermapper map to automatically populate
# Most likely later on, replace these hardcoded valeus with arguments as well
host="intermapper.awesomeurl.com"
username="username"
password="password"

java -jar IntermapperRemoteAccess.jar --host $host --user $username --pass $password --import import.xml

#cleanup
rm -f import.xml
rm -f IntermapperRemoteAccess.jar
