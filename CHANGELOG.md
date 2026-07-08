# Changelog — Tidy

## [1.0.0] — 2026-07-08 🎉 INITIAL RELEASE

### Added
- ✨ **Storage-Dashboard** mit Health-Score (0-100)
- 🔍 **Duplikat-Scanner** (SHA-256 Hash, gruppiert)
- 📦 **Große Dateien** Top 20 (Schwellenwert konfigurierbar)
- 🗑️ **App-Cache-Liste** (YouTube, WhatsApp, Instagram, etc.)
- 💬 **WhatsApp-/Telegram-Analyse** (Killer-Feature)
  - Foto-/Video-/GIF-Anzahl
  - Voice-Notes
  - Alte Medien (>1 Jahr)
  - Weitergeleitete Medien
  - Aufschlüsselung nach Kontakt-Gruppen
- 🛡️ **Sichere Vorschau** vor jeder Löschung (SAF-Integration)
- 📊 **Onboarding** mit Erklärung
- ⚙️ **Settings** (Sprache, Theme, Schwellenwert-Slider)
- 🌍 **DE/EN** Lokalisierung
- 🌓 **Dark Mode** (System/Light/Dark)
- 🎨 **Salbei-Grün + Creme** Theme
- 🔒 **100% Privacy** (kein Backend, keine Tracker)
- 📋 **DSGVO-Privacy-Policy** (HTML, 100% lokal)
- 📸 **App-Icon** 512x512 + 5 Android-Densities
- 🖼️ **Feature Graphic** 1024x500

### Security
- `allowBackup=false` (kein Cloud-Backup)
- KEINE Daten-Collection (Pure-Client)
- KEINE Tracker, KEINE Analytics
- SAF-basierte Löschung (User behält Kontrolle)
- Open Source (Apache 2.0)

### Permissions (Android)
- `READ_MEDIA_IMAGES` (Android 13+)
- `READ_MEDIA_VIDEO` (Android 13+)
- `READ_MEDIA_AUDIO` (Android 13+)
- `READ_EXTERNAL_STORAGE` (Android ≤ 12)
- `MANAGE_EXTERNAL_STORAGE` (Optional, mit User-Confirmation)

### Known Issues
- AAB-Build benötigt x86_64-Build-Server (ARM-Linux-Limit)
- iOS-Build benötigt macOS
- Echte File-System-Scans nur auf Mobile (Web nutzt Demo-Daten)

---

**Maintainer:** Mualimx Apps
**Lizenz:** Apache 2.0
