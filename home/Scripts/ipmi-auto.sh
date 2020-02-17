#!/bin/bash

IPMIHOST=10.0.0.82
IPMIUSER=ReekyMarko
IPMIPW={{@@ env['PASS_IPMI'] @@}}
IPMIEK=0000000000000000000000000000000000000000

printf "Activating dynamic fan control."
ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW -y $IPMIEK raw 0x30 0x30 0x01 0x01
