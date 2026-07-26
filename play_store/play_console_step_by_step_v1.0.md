# Play Console Step-by-Step: Tidy v1.0.0 einreichen

> Anleitung: Du folgst diesen Schritten in der Google Play Console.
> Geschätzter Aufwand: 30-45 Minuten für die Ersteinreichung.
> Datum: 2026-07-23

---

## Voraussetzungen

- [x] Google Play Developer Account (25 € einmalig, bereits vorhanden)
- [x] Developer-Profil vollständig (Mualimx Apps)
- [x] Identitätsverifikation abgeschlossen
- [ ] AAB-File (App-Bundle) — **baust du später auf x86_64-Server**
- [x] Store-Listing-Texte (DE+EN+AR in `listing_v1.0.md`)
- [x] App-Icon 512x512 (`play_store/app_icon_512.png`)
- [x] Feature Graphic 1024x500 (`play_store/feature_graphic.png`)
- [ ] 8 Phone-Screenshots 1080x1920 — **noch erstellen**
- [x] Data Safety Form (in `data_safety_v1.0.md`)
- [x] Privacy Policy (`play_store/privacy_policy.html`)
- [x] Metadata (`metadata_v1.0.json`)

---

## Schritt 1: App erstellen

1. Öffne https://play.google.com/console
2. Klicke **"App erstellen"** (oder "Create app")
3. App-Name: `Tidy`
4. Standardsprache: `Deutsch (Deutschland)`
5. App oder Spiel: **App**
6. Kostenlos oder kostenpflichtig: **Kostenlos**
7. Klicke **"App erstellen"**

## Schritt 2: Dashboard-Aufgaben

Play Console zeigt dir eine Checkliste. Gehe sie der Reihe nach durch:

### ✅ App-Details (Store-Eintrag)

1. Klicke auf **"Hauptseite des Store-Eintrags"** (oder "Main store listing")
2. **App-Name (DE):** `Tidy: Speicher-Cleaner & Scanner` — **30 Zeichen** ✓ (exakt Limit)
3. **Kurzbeschreibung (DE):** `Datei-Cleaner, WhatsApp-Duplikate & Cache-Reiniger. 100% offline. Fair.` — **73 Zeichen** ✓ (< 80)
4. **Vollständige Beschreibung (DE):** Kopiere den DE-Text aus `listing_v1.0.md` komplett rein
5. **App-Icon:** Lade `play_store/app_icon_512.png` hoch
6. **Feature Graphic:** Lade `play_store/feature_graphic.png` hoch
7. **Screenshots:** Lade 8 Phone-Screenshots (1080x1920) hoch
8. Wiederhole für **EN** und **AR** (über "Übersetzungen verwalten"):
   - EN Titel: `Tidy: Storage Cleaner & Scanner` (30 Zeichen ✓)
   - EN Kurzbeschreibung: `File cleaner, WhatsApp duplicates & cache sweeper. 100% offline. Fair.` (74 Zeichen ✓)
   - AR Titel: `Tidy: منظف التخزين والمسح` (29 Zeichen ✓)
   - AR Kurzbeschreibung: `منظف الملفات، مكررات واتساب ومسح ذاكرة التخزين. 100٪ غير متصل.` (63 Zeichen ✓)
9. Klicke **"Speichern"**

### ✅ App-Inhalt

1. **"Datenschutz"** → URL: `https://mualimx.com/privacy/tidy.html`
2. **"Datensicherheit"** → **Keine Daten gesammelt** — alle 14 Kategorien auf "No"
3. **"Anzeigen"** → **Nein**
4. **"Inhaltsklassifizierung"** (IARC) → Alle 5 Fragen mit **Nein** → PEGI 3
5. **"Zielgruppe"** → **Alle Altersgruppen**

### ✅ In-App-Käufe (Premium Lifetime)

1. Gehe zu **"Monetarisierung"** → **"Produkte"** → **"In-App-Produkt erstellen"**
2. Produkt-ID: `premium_lifetime`
3. Name (DE): `Tidy Premium`
4. Beschreibung (DE): `Einmaliger Kauf. Lebenslange Updates. Alle Premium-Features freischalten.`
5. Preis: **4,99 EUR** (vor Steuern)
6. Typ: **Non-consumable** (nicht konsumierbar)
7. Status: **Aktiv**
8. Speichern

> Wichtig: **Non-consumable**, kein Abo! Sonst lehnt Google den IAP-Typ ab.

### ✅ App-Berechtigungen

- Tidy benötigt **Speicher-Berechtigungen** (READ_MEDIA_IMAGES etc.)
- Diese werden Laufzeit angefragt, nicht automatisch
- Kein INTERNET-Permission deklariert
- Keine sensiblen Berechtigungen (Kamera, Mikrofon, Kontakte)

## Schritt 3: App-Version hochladen

1. Gehe zu **"Release"** → **"Produktion"** oder **"Interner Test"**
2. **"Neue Version erstellen"**
3. Lade `.aab` File hoch
4. **Versionsname:** `1.0.0`
5. **Versionscode:** `1`
6. **Versionshinweise (DE):** z.B. "Erster Release von Tidy: Duplikat-Scanner, WhatsApp-Analyse, Cache-Reiniger"
7. Klicke **"Überprüfen"** → **"Rollout starten"**

## Schritt 4: Warten & Nachbereitung

- Google Review: **3-7 Tage**
- E-Mail abwarten
- Reviews beantworten, Statistiken überwachen
- Marketing-Posts publishen

---

## ⚠️ Häufige Probleme & Lösungen

| Problem | Lösung |
|---|---|
| "Speicher-Berechtigung nicht ausreichend begründet" | In der Beschreibung erklären: Datei-Scan-Funktion benötigt Zugriff |
| "App-Bundle rejected: permissions" | In App-Content → Permissions begründen: STORAGE ist Core-Feature |
| "Data Safety: contradicted by code" | Tidy hat keine Netzwerk-Code — darauf hinweisen |
| "IAP wrong type" | Sicherstellen: non-consumable, nicht subscription |
| "Kurzbeschreibung zu lang" | Auf 80 Zeichen prüfen: DE 73 ✅, EN 74 ✅, AR 63 ✅ |

## 📋 Charakter-Limits (Quick Reference)

| Feld | Limit | Unser Wert | Status |
|---|---|---|---|
| Titel DE | 30 | 30 | ✅ (exakt) |
| Titel EN | 30 | 30 | ✅ (exakt) |
| Titel AR | 30 | 29 | ✅ |
| Kurzbeschreibung DE | 80 | 73 | ✅ |
| Kurzbeschreibung EN | 80 | 74 | ✅ |
| Kurzbeschreibung AR | 80 | 63 | ✅ |
| Vollständige Beschreibung | 4000 | ~1700 chars | ✅ |

## 📞 Support

Falls du nicht weiterkommst: schreib mir, ich helfe sofort.

---

**Geschätzter Aufwand:** 30-45 Minuten
