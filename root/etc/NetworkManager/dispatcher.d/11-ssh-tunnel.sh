#!/bin/bash
if [[ "$2" == "up" ]] || [ "$2" == "vpn-up"]]; then
	su - reekymarko -c 'ssh -f -N -R 8123:localhost:22 teapot sleep 10'
fi

if [[ "$2" == "down" ]] || [ "$2" == "vpn-up"]];then
	killall ssh
fi
