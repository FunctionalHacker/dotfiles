#!/bin/sh

set -e

# The IP address or hostname where the remote computer can be reached
REMOTE_HOST="moria"

# Remote computer's SSH port
REMOTE_SSH_PORT="221"

# SSH command to connect the remote computer via SSH
REMOTE_SSH="ssh -p $REMOTE_SSH_PORT moria"

# SSH command to connect the remote computer via SSH for unlocking
REMOTE_SSH_UNLOCK="ssh -p $REMOTE_SSH_PORT moria-unlock"

wait_for_down() {
  while ping -c 1 -W 1 "$REMOTE_HOST" >/dev/null 2>&1; do
    sleep 1
  done
}

wait_for_up() {
  while ! nc -w 1 -z "$REMOTE_HOST" "$REMOTE_SSH_PORT" >/dev/null 2>&1; do
    sleep 1
  done
}

run_ssh() {
  if ! eval "$1"; then
    if [ "$2" != "allow-fail" ]; then
      echo "SSH failed: $1"
      exit 1
    fi
  fi
}

echo "Rebooting remote now"
run_ssh "$REMOTE_SSH 'reboot'"
echo "Waiting for remote to go down..."
wait_for_down

echo "Waiting for remote to come back up..."
wait_for_up

echo "Remote is ready for unlock"
run_ssh "$REMOTE_SSH_UNLOCK" allow-fail

echo "Waiting for remote to come back up..."
sleep 3
wait_for_up

echo "Remote is back online, starting SSH session"
run_ssh "$REMOTE_SSH"
