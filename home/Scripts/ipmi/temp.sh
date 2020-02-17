#!/bin/bash

IPMIHOST=10.0.0.82
IPMIUSER=ReekyMarko
IPMIPW={{@@ env['PASS_IPMI'] @@}}
IPMIEK=0000000000000000000000000000000000000000
MAXTEMP=27
TEMP=$(ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW -y $IPMIEK sdr type temperature |grep Ambient |grep degrees |grep -Po '\d{2}' | tail -1)

echo $TEMP > /tmp/idrac-temp


if [[ $TEMP > $MAXTEMP ]];
  then
    printf "Warning: Temperature is too high! Activating dynamic fan control! ($TEMP C)"
    ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW -y $IPMIEK raw 0x30 0x30 0x01 0x01
  else
    printf "Temperature is OK ($TEMP C)"
fi
