#!/bin/bash
set -e

# A7800 emulator dependencies
sudo apt-get update
sudo apt-get install -y \
    libsdl2-2.0-0 \
    libqt5widgets5 \
    libsdl2-ttf-2.0-0 \
    libc6-i386 \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    openbox \
    dbus-x11

# wasmtime runtime for WASM-based compilers (batari Basic, 7800basic)
curl https://wasmtime.dev/install.sh -sSf | bash
sudo ln -sf /home/vscode/.wasmtime/bin/wasmtime /usr/local/bin/wasmtime
