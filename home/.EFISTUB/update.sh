#!/bin/bash

# remove old entries
for bootentry in $(efibootmgr | head -n 3 | tail -n 1 | cut -d' ' -f2- | sed 's/,/\n/g'); do
	sudo efibootmgr -qBb $bootentry
done

# add all entries back
for bootscript in *.efi; do
	./$bootscript
done

# set bootorder
sudo efibootmgr --bootorder 0000,0001,0002
