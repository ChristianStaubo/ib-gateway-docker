#!/bin/bash
set -e

echo "Starting Xvfb..."
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1
sleep 2

echo "Starting socat (enables external bot connection)..."
socat TCP-LISTEN:4002,fork TCP:127.0.0.1:4002 &

echo "Launching IB Gateway..."
./ibgateway &

echo "Waiting for IB Gateway UI to start..."
sleep 15

echo "Running login script..."
login.sh

# Block container to keep it running
tail -f /dev/null
