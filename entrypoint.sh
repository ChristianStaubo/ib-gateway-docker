#!/bin/bash
set -e

echo "📺 Starting Xvfb..."
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1
sleep 2

echo "🔌 Starting VNC server..."
x11vnc -display :1 -nopw -forever -shared -bg

echo "🌐 Starting socat for port forwarding..."
socat TCP-LISTEN:4002,fork TCP:127.0.0.1:4002 &

echo "🚀 Launching IB Gateway in API mode..."
./ibgateway -g &

echo "⏳ Waiting for IB Gateway UI to start..."
sleep 15

echo "🤖 Running login automation..."
/usr/local/bin/login.sh

# Keep the container alive
tail -f /dev/null
