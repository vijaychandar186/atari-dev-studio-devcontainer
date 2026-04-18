#!/bin/bash
set -euo pipefail

pkill -9 x11vnc 2>/dev/null || true
pkill openbox 2>/dev/null || true
pkill -9 Xvfb 2>/dev/null || true
pkill -9 websockify 2>/dev/null || true
sleep 2
fuser -k 5901/tcp 2>/dev/null || true
fuser -k 6080/tcp 2>/dev/null || true
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

echo ">>> Starting Xvfb..."
Xvfb :1 -screen 0 1440x900x24 &
sleep 2

if command -v dbus-launch >/dev/null 2>&1; then
    echo ">>> Starting D-Bus session..."
    eval "$(dbus-launch --sh-syntax)"
fi

echo ">>> Starting Openbox..."
DISPLAY=:1 openbox-session &
sleep 2

echo ">>> Starting x11vnc..."
mkdir -p "$HOME/.vnc"
x11vnc -display :1 -passwd password -rfbport 5901 -forever -noxdamage -quiet &
sleep 2

echo ">>> Starting noVNC..."
websockify --web=/usr/share/novnc 6080 localhost:5901 &
sleep 2

echo ""
echo "======================================================"
echo "  Atari Dev Studio virtual display is ready!"
echo "  Open: https://<codespace-name>-6080.app.github.dev/vnc.html"
echo "  VNC password: password"
echo ""
echo "  Press F5 in VS Code to build and launch Stella."
echo "======================================================"

mkdir -p /tmp/runtime-vscode && chmod 700 /tmp/runtime-vscode
