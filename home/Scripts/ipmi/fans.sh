#!/bin/bash

IPMIHOST=10.0.0.82
IPMIUSER=ReekyMarko
IPMIPW={{@@ env['PASS_IPMI'] @@}}
IPMIEK=0000000000000000000000000000000000000000

mkdir -p /tmp/ipmi

DATA=`ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW -y $IPMIEK sdr get "FAN 1 RPM" "FAN 2 RPM" "FAN 3 RPM" "FAN 4 RPM" "FAN 5 RPM" "FAN 6 RPM" | grep "Sensor Reading" | awk '{ print $4 }'`

echo "$DATA"

echo "$DATA" | head -1 | tail -1> /tmp/ipmi/fan1
echo "$DATA" | head -2 | tail -1> /tmp/ipmi/fan2
echo "$DATA" | head -3 | tail -1> /tmp/ipmi/fan3
echo "$DATA" | head -4 | tail -1> /tmp/ipmi/fan4
echo "$DATA" | head -5 | tail -1> /tmp/ipmi/fan5
echo "$DATA" | head -6 | tail -1> /tmp/ipmi/fan6
