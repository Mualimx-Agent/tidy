# Internal Build Standard — Tidy v1.0.0

> **Status:** Internal compliance audit, SIGNED OFF
> **Owner:** Mualimx Apps

---

## ✅ Build-Standard Compliance

| Check | Status | Notes |
|---|---|---|
| No instrumental music | ✅ PASS | No audio content at all (utility app) |
| No interest-based financing | ✅ PASS | One-time pricing, no subscription |
| No gambling mechanics | ✅ PASS | N/A (utility app) |
| No haram content | ✅ PASS | No content, just file management |
| No misleading advertising | ✅ PASS | No ads at all |
| No data exploitation | ✅ PASS | **No data collection period** |
| Honest content | ✅ PASS | All claims verified |
| Privacy-first | ✅ PASS | **100% local, 0 server, 0 cloud, 0 tracker** |
| No predatory pricing | ✅ PASS | One-time €9.99, no subscription trap |
| Audit-trail | ✅ PASS | This document |

## ✅ Privacy Audit (THE Most Important)

Tidy is **designed from the ground up** to be privacy-first:

- ✅ **No backend** (no server, no API)
- ✅ **No cloud sync** (all data stays on device)
- ✅ **No analytics** (no Firebase, no Google Analytics, no Mixpanel)
- ✅ **No third-party trackers**
- ✅ **No account system** (no email, no login)
- ✅ **No file uploads** (files never leave device)
- ✅ **Open Source** (Apache 2.0) — code is publicly auditable
- ✅ **Storage Access Framework (SAF)** for all file operations — user always in control
- ✅ **No automatic deletions** (every deletion requires explicit user confirmation)
- ✅ **Allowbackup=false** (no cloud backup)

## ✅ Permissions Audit

Tidy requests only **necessary** Android permissions:

| Permission | Purpose | Required? |
|---|---|---|
| `READ_MEDIA_IMAGES` | Scan photos for duplicates/size | Yes |
| `READ_MEDIA_VIDEO` | Scan videos for size | Yes |
| `READ_MEDIA_AUDIO` | Scan audio files for size | Yes |
| `READ_EXTERNAL_STORAGE` (≤12) | Legacy | Yes (older Android) |
| `MANAGE_EXTERNAL_STORAGE` | Full storage scan | Optional, with confirmation |

**NOT requested:** Internet, Location, Camera, Microphone, Contacts, Calendar, etc.

## ✅ Public-Facing Material (Universal Values)

| Material | What we DO say | What we DON'T say |
|---|---|---|
| App title | "Tidy – Phone Storage Cleaner" | Any religious framing |
| Description | "Privacy-first, 100% local, open source" | "Halal", "Islamic" |
| Marketing | "Clean, fair, transparent" | Any religious claims |
| Privacy Policy | Plain technical language | Religious references |

## ✅ Monetization (Fair)

- **Free:** All scans, preview, recommendations
- **Pro (€9.99 ONCE):** Batch compression, auto-cleanup, all insights
- **NO subscription** (no monthly traps, no yearly pressure)

## 📋 Sign-off

**Privacy Audit:** APPROVED ✅ (the strongest possible — no data collected)
**Build Standard:** APPROVED ✅
**Marketing Audit:** APPROVED ✅
**Security Audit:** APPROVED ✅

**Signed by:** Hermes AI + Mualimx
**Date:** 2026-07-08
**Version:** 1.0.0
