#!/bin/sh
status=$2
case $status in
    up)
        /usr/bin/tzupdate
esac
