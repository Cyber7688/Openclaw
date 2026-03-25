# 🦀 OpenClaw — VPS/Local Auto-Installer

<div align="center">

<pre align="center">
███████╗██╗  ██╗██╗██████╗  █████╗ 
██╔════╝██║  ██║██║██╔══██╗██╔══██╗
███████╗███████║██║██████╔╝███████║
╚════██║██╔══██║██║██╔══██╗██╔══██║
███████║██║  ██║██║██████╔╝██║  ██║
╚══════╝╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝
</pre>

[![Node.js](https://img.shields.io/badge/Node.js-22.x-green?logo=node.js)](https://nodejs.org/)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-v2026.3.23-blue)](https://www.npmjs.com/package/openclaw)
[![Platform](https://img.shields.io/badge/Platform-Ubuntu%2020.04%2B-orange?logo=ubuntu)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

**Installer otomatis OpenClaw untuk VPS/Local — siap pakai dalam satu perintah.**

</div>

---

## 📋 Daftar Isi

- [Tentang Proyek](#-tentang-proyek)
- [Prasyarat Sistem](#-prasyarat-sistem)
- [Instalasi Cepat](#-instalasi-cepat)
- [Apa yang Diinstal](#-apa-yang-diinstal)
- [Langkah Setelah Instalasi](#-langkah-setelah-instalasi)
- [Pemecahan Masalah](#-pemecahan-masalah)
- [Kontribusi](#-kontribusi)
- [Lisensi](#-lisensi)

---

## 🔍 Tentang Proyek

`OpenClaw Installer` adalah shell script satu-klik yang mengotomasi seluruh proses setup OpenClaw di lingkungan **VPS Ubuntu** maupun **mesin lokal**. Script ini menangani:

- Pembersihan sumber paket yang bermasalah
- Instalasi dependensi sistem (build tools, ffmpeg, python3, dll.)
- Upgrade/instalasi Node.js **v22 (LTS)** secara otomatis
- Instalasi OpenClaw Core (pinned ke versi stabil `v2026.3.23`)
- Setup Chromium via Playwright untuk fitur web research

> **Author:** Shiba  
> **Versi Installer:** Stable Edition  
> **OpenClaw Core:** `v2026.3.23`

---

## 💻 Prasyarat Sistem

| Komponen | Minimum |
|----------|---------|
| OS | Ubuntu **20.04 LTS** atau lebih baru |
| RAM | 1 GB (rekomendasi 2 GB+) |
| Storage | 2 GB ruang bebas |
| Akses | `sudo` / root privileges |
| Koneksi | Internet aktif |

> ⚠️ **Catatan:** Ubuntu di bawah versi 20.04 **tidak didukung** dan installer akan berhenti otomatis.

---

## 🚀 Instalasi Cepat

### Metode 1 — Clone & Run

```bash
# 1. Clone repositori ini
git clone https://github.com/Cyber7688/Openclaw.git
cd openclaw-installer

# 2. Beri izin eksekusi
chmod +x installer.sh

# 3. Jalankan installer
./installer.sh
```

### Metode 2 — One-liner (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/Cyber7688/Openclaw/main/installer.sh | bash
```

> 🔐 **Tips keamanan:** Selalu periksa isi script sebelum menjalankannya dengan `curl ... | bash`. Baca kodenya dulu!

---

## 📦 Apa yang Diinstal

Installer menjalankan 5 tahap secara berurutan:

```
[1/5] System Dependencies
      └── curl, git, build-essential, ffmpeg, python3, pkg-config, make, g++, ca-certificates

[2/5] Node.js v22 (LTS)
      └── Auto-upgrade jika versi lama terdeteksi, skip jika sudah v22+

[3/5] OpenClaw Core
      └── npm install -g openclaw@2026.3.23

[4/5] Chromium & Browser Modules
      └── playwright install-deps chromium
      └── playwright install chromium

[5/5] ✅ Selesai!
```

---

## ⚙️ Langkah Setelah Instalasi

Setelah installer selesai, jalankan dua perintah berikut:

### 1. Konfigurasi Awal (Onboarding)

```bash
openclaw onboard
```

Ikuti wizard interaktif untuk mengatur:
- 🤖 **Telegram Bot** — masukkan Bot Token dari [@BotFather](https://t.me/BotFather)
- 💬 **Discord Setup** — masukkan Discord Bot Token & Channel ID
- 🔧 Pengaturan lainnya sesuai kebutuhan

### 2. Jalankan Gateway

```bash
openclaw gateway
```

OpenClaw akan aktif dan siap menerima perintah via Telegram/Discord.

---

## 🛠️ Pemecahan Masalah

### ❌ "Your Ubuntu version is too old"

```
Solusi: Upgrade ke Ubuntu 20.04 LTS atau lebih baru.
```

### ❌ Error saat install Node.js

```bash
# Hapus Node.js lama dan install ulang secara manual
sudo apt remove nodejs npm -y
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```

### ❌ Playwright / Chromium gagal

```bash
# Install ulang dependensi browser
sudo npx playwright install-deps chromium
sudo npx playwright install chromium
```

### ❌ Permission denied saat menjalankan script

```bash
chmod +x installer.sh
sudo ./installer.sh
```

---

## 🌐 Variabel Lingkungan (Opsional)

Jika kamu mengembangkan atau mengkustomisasi OpenClaw, buat file `.env`:

```env
# Telegram
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
TELEGRAM_CHAT_ID=your_chat_id_here

# Discord
DISCORD_TOKEN=your_discord_bot_token_here
DISCORD_CHANNEL_ID=your_channel_id_here

# General
LOG_LEVEL=info
NODE_ENV=production
```

> 🔒 **JANGAN** pernah commit file `.env` ke GitHub! Pastikan sudah ada di `.gitignore`.

---

## 📁 Struktur Repositori

```
Openclaw/
├── installer.sh        # Script installer utama
├── README.md           # Dokumentasi ini
├── .gitignore          # File yang diabaikan Git
└── LICENSE             # Lisensi proyek
```

---

## 🤝 Kontribusi

Pull Request dan issue sangat disambut! Ikuti langkah berikut:

1. **Fork** repositori ini
2. Buat branch baru: `git checkout -b feat/nama-fitur`
3. Commit perubahan: `git commit -m "feat: deskripsi perubahan"`
4. Push ke branch: `git push origin feat/nama-fitur`
5. Buka **Pull Request**

---

## 📄 Lisensi

Didistribusikan di bawah lisensi **MIT**. Lihat [`LICENSE`](LICENSE) untuk informasi lengkap.

---

<div align="center">

Made with ❤️ by **Shiba** · [Report Bug](../../issues) · [Request Feature](../../issues)

</div>
