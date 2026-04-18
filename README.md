# Atari Dev Studio — Dev Container

A ready-to-use VS Code Dev Container for developing Atari 2600 and 7800 homebrew games using [Atari Dev Studio](https://github.com/chunkypixel/atari-dev-studio).

Includes batari Basic, 7800basic, dasm, Stella (2600 emulator), and A7800 (7800 emulator) — all pre-configured.

## Requirements

- A GitHub account with Codespaces access
- A browser

## Getting Started

### 1. Open a Codespace

Open the repository on GitHub and click **Code → Codespaces → Create codespace on main**.

The devcontainer will automatically:

- Pull the base Debian image
- Install A7800 emulator dependencies (`libsdl2`, `libqt5widgets5`, `libsdl2-ttf`, `libc6-i386`)
- Install `wasmtime` for WASM-based compilers (batari Basic, 7800basic)
- Install Xvfb, x11vnc, noVNC, and Openbox for the virtual display
- Install the Atari Dev Studio VS Code extension

### 2. Start the virtual display

Once the Codespace is ready, run in the terminal:

```bash
bash start.sh
```

### 3. Open the virtual desktop in your browser

```
https://<your-codespace-name>-6080.app.github.dev/vnc.html
```

VNC password: **password**

### 4. Build and run

Open any `.bas` file in VS Code and press **F5**. Stella will launch inside the virtual desktop.

## Project Structure

```
.devcontainer/
  devcontainer.json   # Dev Container configuration
  setup.sh            # Post-create setup script
sample/
  game.bas            # Minimal batari Basic sample (Atari 2600)
start.sh              # Starts Xvfb + x11vnc + noVNC virtual display
```

## Writing Your First Game

Open any `.bas` file to activate the extension. The status bar at the bottom shows the active language and compile shortcuts.

| Shortcut | Action |
|----------|--------|
| `F5` | Compile and run in emulator |
| `Shift+F5` | Compile only (outputs a `.bin` ROM) |
| `Ctrl+Shift+P` → `ads` | Browse all extension commands |

### Language by file extension

| Extension | Language |
|-----------|----------|
| `.bas`, `.bb` | batari Basic (2600) |
| `.bas`, `.78b` | 7800basic (7800) |
| `.asm`, `.dasm` | dasm (assembly) |

Use the `;#ADSLanguage=` tag at the top of your file to explicitly set the language:

```basic
;#ADSLanguage=batariBasic
```

## Testing with the Sample

Open [sample/game.bas](sample/game.bas) and press **F5**. Stella will launch in the noVNC browser tab and display a color-cycling screen — confirmation that compilation and emulation are both working.

## How It Works

| Component | Role |
|-----------|------|
| `Xvfb` | Virtual display for GUI apps in the container |
| `x11vnc` | Exposes the display over VNC |
| `noVNC + websockify` | Browser access to the VNC session |
| `openbox` | Lightweight window manager |
| `Stella` | Atari 2600 emulator (bundled with extension) |
| `A7800` | Atari 7800 emulator (bundled with extension) |

## Notes

- Base image: `mcr.microsoft.com/devcontainers/base:trixie`
- Virtual desktop is accessible on port `6080`
- VNC password is hardcoded as `password` in `start.sh` — update it if needed
- `DISPLAY`, `XDG_RUNTIME_DIR`, and `SDL_AUDIODRIVER` are set in `devcontainer.json` so Stella picks them up when launched by the extension via F5
