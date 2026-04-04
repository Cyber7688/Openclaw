#!/bin/bash
# ================================================
#  OpenClaw VPS/Local Installer (Stable Edition)
#  Project: OpenClaw_Installer
#  Author: Shiba
# ================================================

set -Eeuo pipefail

# Colors
BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${GREEN}"
echo "███████╗██╗  ██╗██╗██████╗  █████╗ "
echo "██╔════╝██║  ██║██║██╔══██╗██╔══██╗"
echo "███████╗███████║██║██████╔╝███████║"
echo "╚════██║██╔══██║██║██╔══██╗██╔══██║"
echo "███████║██║  ██║██║██████╔╝██║  ██║"
echo "╚══════╝╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝"
echo -e "${RESET}"
sleep 3

echo -e "${CYAN}============================================${RESET}"
echo -e "${CYAN}      OPENCLAW VPS/LOCAL AUTO-INSTALLER     ${RESET}"
echo -e "${CYAN}============================================${RESET}"

ok() { echo -e "${GREEN}✔ $1${RESET}"; }
warn() { echo -e "${YELLOW}⚠ $1${RESET}"; }
info() { echo -e "${BLUE}ℹ $1${RESET}"; }

# 0. Check OS Compatibility
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" = "ubuntu" ]; then
        VERSION_MAJOR=$(echo "$VERSION_ID" | cut -d'.' -f1)
        if [ "$VERSION_MAJOR" -lt 20 ]; then
            echo -e "${RED}[ERROR] Your Ubuntu version ($VERSION_ID) ) is too old.${RESET}"
            echo -e "${YELLOW}OpenClaw and Node.js 22 require at least Ubuntu 20.04.${RESET}"
            exit 1
        fi
    fi
fi

# 1. Update & Install Basic Tools
echo -e "\n${BLUE}[1/5]${RESET} Checking System Dependencies..."
warn "Cleaning up problematic package sources..."
sudo rm -f /etc/apt/sources.list.d/yarn.list || true
sudo sed -i '/yarnpkg/d' /etc/apt/sources.list || true
find /etc/apt/sources.list.d/ -type f -name "*.list" -exec sudo sed -i '/yarnpkg/d' {} + || true

sudo apt update -y
sudo apt install -y curl git build-essential ffmpeg python3 pkg-config make g++ ca-certificates
ok "System dependencies ready!"

# 2. Check Node.js
echo -e "\n${BLUE}[2/5]${RESET} Checking Node.js Environment..."
if command -v node > /dev/null 2>&1; then
    NODE_VER=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VER" -ge 22 ]; then
        ok "Node.js $(node -v) sudah terinstall, skip."
    else
        warn "Node.js versi lama terdeteksi (v$NODE_VER). Upgrade ke v22..."
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
        sudo apt install -y nodejs
    fi
else
    info "Node.js tidak ditemukan. Menginstall v22 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt install -y nodejs
fi
ok "Node.js ready!"

# 3. Install OpenClaw (Pinned to v2026.4.2)
echo -e "\n${BLUE}[3/5]${RESET} Installing OpenClaw Core (v2026.4.2)..."
sudo npm install -g openclaw@2026.4.2
ok "OpenClaw core installed!"
chmod +x "$HOME/openclaw/openclaw" 2>/dev/null || true
sudo chmod +x /usr/local/bin/openclaw 2>/dev/null || true

# 4. Install Browser & Modules
echo -e "\n${BLUE}[4/5]${RESET} Installing Chromium & Browser Modules..."
warn "Setting up Chromium for web research tools..."
sudo npx playwright install-deps chromium || true
sudo npx playwright install chromium || true
ok "Chromium and browser modules ready!"

# 5. Finish
echo -e "\n${GREEN}============================================${RESET}"
echo -e "${GREEN}      INSTALLATION PROCESS COMPLETED!       ${RESET}"
echo -e "${GREEN}============================================${RESET}"
if [ -x "/usr/local/bin/openclaw" ]; then
    ok "Instalasi berhasil dan executable terdeteksi."
else
    warn "Instalasi selesai, tapi executable /usr/local/bin/openclaw tidak terdeteksi."
fi

echo -e "${YELLOW}Next steps to get started:${RESET}"
echo -e "1. Configure: ${CYAN}openclaw onboard${RESET}"
echo -e "2. Run:       ${CYAN}openclaw gateway${RESET}"
echo ""
echo -e "${BLUE}Selamat Menikmati! Jangan lupa mengatur Telegram, Discord Setup ya...${RESET}"
