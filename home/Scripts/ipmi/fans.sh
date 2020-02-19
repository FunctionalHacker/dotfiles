#!/bin/bash

IPMIHOST=10.0.0.82
IPMIUSER=ReekyMarko
IPMIPW={{@@ env['PASS_IPMI'] @@}}
IPMIEK=0000000000000000000000000000000000000000

DATA=`ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW -y $IPMIEK sdr get "FAN 1 RPM" "FAN 2 RPM" "FAN 3 RPM" "FAN 4 RPM" "FAN 5 RPM" "FAN 6 RPM" | grep "Sensor Reading" | awk '{ print $4 }'`

echo "$DATA"

mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan1" -m "$(echo "$DATA" | head -1 | tail -1)"
mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan2" -m "$(echo "$DATA" | head -2 | tail -1)"
mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan3" -m "$(echo "$DATA" | head -3 | tail -1)"
mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan4" -m "$(echo "$DATA" | head -4 | tail -1)"
mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan5" -m "$(echo "$DATA" | head -5 | tail -1)"
mosquitto_pub -u reekynet -P {{@@ env['PASS_MQTT'] @@}} -t "ipmi/fan6" -m "$(echo "$DATA" | head -6 | tail -1)"
