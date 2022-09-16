#!/bin/bash

NEWMAILDIR=~/.mail/$1/INBOX/new
COUNT=$(ls $NEWMAILDIR | wc -l)
ICON=/usr/share/icons/Papirus-Dark/64x64/apps/email.svg
SOUND=/usr/share/sounds/Oxygen-Im-Message-In.ogg

if [ $COUNT -ne 0 ]; then
  mpv $SOUND &
fi

if [ $COUNT -gt 1 ]; then
  fromaddress=$(cat $NEWMAILDIR/$(ls $NEWMAILDIR | sort -R | tail -1) | formail -x From | tail -1)
  notify-send.sh -i $ICON "$COUNT new messages in $1" "From $fromaddress and others"

elif [ $COUNT -eq 1 ]; then
  mailsubject=$(cat $NEWMAILDIR/* | formail -x Subject)
  fromaddress=$(cat $NEWMAILDIR/* | formail -x From | tail -1)

  notify-send.sh -i $ICON "New message in $1" "$fromaddress $mailsubject"
else
  echo "No new mail"
fi
