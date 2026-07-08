# Tidy v1.0.0

> **Privacy-first phone storage cleaner. 100% local, no trackers, open source.**
> Built by **Mualimx Apps** — clean, fair, transparent.

---

## ✨ Was ist Tidy?

Tidy ist die **faire Alternative zu CCleaner & Co.**:
- 🔍 **Duplikat-Scan** (SHA-256) — finde gleiche Dateien
- 📦 **Große Dateien** — sortiert nach Größe
- 🗑️ **App-Caches** — sieh, was andere Apps an Müll hinterlassen
- 💬 **WhatsApp-/Telegram-Analyse** — Killer-Feature, das niemand sonst hat!
- 🔒 **100% lokal**, 0 Cloud, 0 Tracker
- 💰 **Einmalkauf €9.99** statt Abo-Modell

## 🏗️ Architektur (Pure-Client!)

```
Flutter App (Android + iOS + Web)
        ↓
Photo Manager Plugin (Android/iOS)
        ↓
Lokales Dateisystem (KEIN Backend!)
```

**Wichtig:** Tidy hat **kein Backend**, weil Privacy-First = keine Daten = kein Server. 100% Client-Side.

## 🛠️ Tech-Stack

- **Frontend:** Flutter 3.44.2, Riverpod, GoRouter, Hive
- **Photo-Library:** photo_manager (Android MediaStore / iOS PhotoKit)
- **Permissions:** permission_handler
- **Hashing:** crypto (SHA-256)
- **Storage:** shared_preferences (Settings), Hive (Scan-History)

## ✨ Features

### MVP (v1.0.0)
- ✅ **Storage-Dashboard** mit Health-Score (0-100)
- ✅ **Duplikat-Scanner** (SHA-256, gruppiert in Clustern)
- ✅ **Große Dateien** Top 20 (konfigurierbarer Schwellenwert)
- ✅ **App-Cache-Liste** (YouTube, WhatsApp, Instagram, etc.)
- ✅ **WhatsApp-/Telegram-Analyse** (Killer-Feature)
  - Foto-/Video-/GIF-Anzahl
  - Voice-Notes
  - Alte Medien (>1 Jahr)
  - Weitergeleitete Medien
  - Aufschlüsselung nach Kontakt-Gruppen
- ✅ **Sichere Vorschau** vor jedem Löschen
- ✅ **Onboarding** mit Erklärung
- ✅ **Settings** (Sprache, Theme, Schwellenwert)
- ✅ **DE/EN** Lokalisierung
- ✅ **Dark Mode**
- ✅ **DSGVO-Privacy** (HTML, in App verlinkt)

## 📁 Projektstruktur

```
tidy/
├── app/tidy_app/                  # Flutter App (12+ Dart-Files, 8 Screens)
│   ├── lib/
│   │   ├── main.dart
│   │   ├── theme/app_theme.dart   # Salbei-Grün + Creme
│   │   ├── router/app_router.dart # GoRouter (8 Routen)
│   │   ├── models/                # Storage, Duplicate, LargeFile, AppCache
│   │   ├── providers/             # State Management
│   │   ├── screens/               # 8 Screens
│   │   └── services/storage_scanner.dart  # Scan-Engine
│   ├── android/                   # Android-Build (Permissions konfiguriert)
│   ├── ios/                       # iOS-Build
│   └── assets/
│
├── play_store/                    # Play-Store-Material
│   ├── privacy_policy.html        # DSGVO (sehr kurz, weil keine Daten)
│   ├── feature_graphic.png        # 1024x500
│   └── app_icon_512.png
│
└── workspace/halal-audits/        # Interne Compliance
```

## 🚀 Build & Run

### Flutter Web (Demo-Modus)
```bash
cd ~/mualimx-apps/tidy/app/tidy_app
flutter pub get
flutter build web --release
cd build/web && python3 -m http.server 8092
```

### Android (echte Scans)
```bash
cd ~/mualimx-apps/tidy/app/tidy_app
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk
```

> **Hinweis:** AAB-Build benötigt x86_64-Build-Server (ARM-Linux-Limit, gleicher Workaround wie FocusFlow/StillMind).

## 🧪 Test-Status

| Test | Status |
|---|---|
| `flutter analyze` | ✅ 0 errors (26 info) |
| Web-Build | ✅ 41 MB, läuft auf Port 8092 |
| Android Manifest | ✅ Permissions konfiguriert |
| App-Icon | ✅ 5 Densities + 512x512 |
| Feature Graphic | ✅ 1024x500 |
| Privacy Policy | ✅ DSGVO-konform |

## 🎯 Storage-Health-Score (0-100)

Tidy berechnet einen einfachen, ehrlichen Score:
- **>30% frei** = 100 (Excellent)
- **5-30% frei** = linear 0-100
- **<5% frei** = 0 (Critical)

**Beispiel:** 92 GB belegt von 128 GB = 28% frei = ~92/100 = "Excellent"

## 🛡️ Sicherheit & Privacy

- **KEIN Backend** (kein Server, keine Cloud)
- **100% lokal** (alle Scans auf dem Gerät)
- **KEINE Tracker** (kein Firebase, kein Google Analytics, etc.)
- **Sichere Vorschau** vor jeder Löschung
- **SAF (Storage Access Framework)** — User behält Kontrolle
- **allowBackup=false** (kein Cloud-Backup)
- **Open Source** (Apache 2.0)

## 💰 Monetarisierung

- **Free:** Alle Scans, Vorschau, Empfehlungen
- **Pro (€9.99 EINMALIG):** Batch-Komprimierung, Auto-Cleanup, alle Insights
- **KEIN Abo** (User-Pattern: fair pricing)

## 📜 Lizenz

Apache 2.0

## 🤝 Entwicklung

Entwickelt durch Hermes AI im Auftrag von Mualimx (Mualimx Apps).
Mensch + KI als Team — der Mensch entscheidet, die KI baut.

## 📞 Kontakt

- **Entwickler:** Mualimx Apps
- **Email:** mail2mualimx@gmail.com

---

> ✨ *Built clean, fair, private. By Mualimx Apps.*
