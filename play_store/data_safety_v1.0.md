# Data Safety Form – Tidy v1.0.0

> Antworten für Google Play Console Data Safety Questionnaire.
> Datum: 2026-07-23

## Section 1: Data collection and security

**Q: Does your app collect or share any of the required user data types?**
A: **No**

**Q: Is all of the user data collected by your app encrypted in transit?**
A: N/A — no data collected

**Q: Do you provide a way for users to request that their data is deleted?**
A: N/A — no data collected

## Section 2: Specific data types (all 14 categories)

Tidy does **NOT** collect, store, or share any of the following data types:

1. ❌ **Location** (approximate or precise)
2. ❌ **Personal info** (name, email, phone, address)
3. ❌ **Financial info** (payment, credit card, bank account)
4. ❌ **Health and fitness**
5. ❌ **Messages** (SMS, MMS, email, other)
6. ❌ **Photos and videos** (app scans these locally but never collects/transmits them)
7. ❌ **Audio files** (scanned locally, never collected)
8. ❌ **Files and docs** (scanned locally, never collected)
9. ❌ **Calendar**
10. ❌ **Contacts**
11. ❌ **App activity** (no analytics, no interaction logs)
12. ❌ **Web browsing**
13. ❌ **App info and performance** (no crash logs, no diagnostics)
14. ❌ **Device or other IDs** (no device identifier, no advertising ID)

## What Tidy DOES access (locally only)

| Data | Where | Why |
|---|---|---|
| File metadata (path, size, hash) | User's device (in-memory during scan) | Core feature: duplicate & large file detection |
| App cache sizes | User's device (in-memory during scan) | Core feature: cache cleaning |
| WhatsApp/Telegram media count | User's device (in-memory during scan) | Core feature: messaging app analysis |
| User settings (threshold, language, theme) | User's device (SharedPreferences) | App customization |
| Scan history (deletion log) | User's device (Hive, optional) | User audit trail |

**All of this stays on the user's device. None of it is transmitted to any server.**
**Tidy has NO backend server.**

## Permissions

Tidy requires storage permissions ONLY at the user's explicit request for scanning.
- READ_MEDIA_IMAGES / READ_MEDIA_VIDEO / READ_MEDIA_AUDIO (Android 13+)
- READ_EXTERNAL_STORAGE (Android 12 and below)
- WRITE_EXTERNAL_STORAGE (only when user chooses to delete files)

No internet permission is declared or used.

## Verification

- ✅ No backend server
- ✅ No third-party SDKs (Firebase, Google Analytics, Crashlytics, etc.)
- ✅ No internet permission
- ✅ Open source code (Apache 2.0)
- ✅ Privacy policy states this explicitly
- ✅ `allowBackup=false` (no cloud backup)
- ✅ SAF (Storage Access Framework) — user controls every operation

## Privacy policy URL

To be hosted at: `https://mualimx.com/privacy/tidy.html`

## Notes for Google reviewer

If asked: "Tidy is a fully offline file cleaner with no backend server. All file scanning
happens exclusively on the user's device. The app does not collect, transmit, or share any
user data. Storage permissions are requested only for the core scanning functionality and
only when the user initiates a scan. The app's code is open source (Apache 2.0) and
can be verified at github.com/mualimx/tidy."

## Offline app stance (summary)

Tidy is built on a strict offline-first principle:
- **No** data is collected from the user's device.
- **No** data leaves the user's device.
- **No** data is shared with third parties.
- **No** tracking, analytics, or advertising.
- **No** backend server.
- All app functionality works without internet connection.
