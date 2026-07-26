#!/usr/bin/env python3
"""Generate 8 Play Store screenshots (1080x1920) for Tidy (Utilities/Storage)."""

import os, math
from PIL import Image, ImageDraw, ImageFont

OUT = os.path.join(os.path.dirname(__file__), "screenshots")
os.makedirs(OUT, exist_ok=True)

W, H = 1080, 1920
FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"

# ── helpers ──────────────────────────────────────────────────────
def _gradient(draw, w, h, c1, c2, vertical=True):
    steps = h if vertical else w
    for i in range(steps):
        t = i / max(steps - 1, 1)
        r = int(c1[0] + (c2[0] - c1[0]) * t)
        g = int(c1[1] + (c2[1] - c1[1]) * t)
        b = int(c1[2] + (c2[2] - c1[2]) * t)
        if vertical:
            draw.line([(0, i), (w, i)], fill=(r, g, b))
        else:
            draw.line([(i, 0), (i, h)], fill=(r, g, b))

def _rrect(draw, xy, r, fill=None, outline=None, width=1):
    draw.rounded_rectangle(xy, radius=r, fill=fill, outline=outline, width=width)

def _card(draw, x, y, w, h, r=24, fill=(255, 255, 255, 30)):
    _rrect(draw, (x, y, x + w, y + h), r, fill=fill)

def _load(sz):
    return ImageFont.truetype(FONT, sz)

def _status_bar(draw, text="9:41"):
    f = _load(32)
    draw.text((W//2, 48), text, font=f, fill="white", anchor="mm")
    draw.rectangle((W - 110, 36, W - 60, 46), fill="white")
    draw.rectangle((W - 58, 39, W - 55, 43), fill="white")
    draw.rectangle((W - 106, 38, W - 80, 44), fill=(255, 255, 255, 120))

C1 = (230, 126, 34)    # #E67E22
C2 = (243, 156, 18)    # #F39C12

def _header_bar(draw, title="Tidy", subtitle=""):
    _status_bar(draw)
    f_title = _load(52)
    f_sub   = _load(30)
    draw.text((W//2, 130), title, font=f_title, fill="white", anchor="mm")
    if subtitle:
        draw.text((W//2, 183), subtitle, font=f_sub, fill=(255, 255, 255, 200), anchor="mm")

# =====================================================================
# SCREENSHOT 1 – home_cleanup
# =====================================================================
def shot_home_cleanup():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Speicher aufräumen")

    # storage pie chart (circular arc representation)
    cx, cy = 200, 380
    d.ellipse([cx-90, cy-90, cx+90, cy+90], outline=(255, 255, 255, 50), width=6)
    # donut using arc
    d.arc([cx-90, cy-90, cx+90, cy+90], 0, 150, fill=(255, 255, 255, 180), width=18)
    d.arc([cx-90, cy-90, cx+90, cy+90], 150, 360, fill=(255, 255, 255, 60), width=18)

    # storage labels
    d.text((cx, cy - 20), "47%", font=_load(48), fill="white", anchor="mm")
    d.text((cx, cy + 30), "belegt", font=_load(26), fill=(255, 255, 255, 170), anchor="mm")

    # storage details
    detail_x = 400
    d.text((detail_x, 290), "Speicherübersicht", font=_load(36), fill="white")
    items = [("Gesamt", "64 GB"), ("Verwendet", "30,2 GB"), ("Frei", "33,8 GB")]
    for i, (lbl, val) in enumerate(items):
        yy = 350 + i * 75
        d.text((detail_x, yy), lbl, font=_load(30), fill=(255, 255, 255, 160))
        d.text((detail_x + 250, yy), val, font=_load(30), fill="white")

    # Quick Clean card
    _card(d, 60, 520, W - 120, 140, fill=(255, 255, 255, 30))
    d.text((150, 560), "⚡ Quick Clean", font=_load(40), fill="white")
    d.text((150, 615), "2,4 GB potentieller Müll gefunden", font=_load(28), fill=(255, 255, 255, 170))
    _rrect(d, (W - 260, 555, W - 120, 610), 20, fill="white")
    d.text((W - 190, 582), "Reinigen", font=_load(28), fill=C1, anchor="mm")

    # category cards
    cats = [
        ("📷", "Bilder", "1,2 GB"),
        ("🎬", "Videos", "8,5 GB"),
        ("🎵", "Audio", "3,1 GB"),
        ("📄", "Dokumente", "0,8 GB"),
    ]
    for i, (emoji, lbl, size) in enumerate(cats):
        xx = 60 + i * 255
        _card(d, xx, 720, 225, 180, fill=(255, 255, 255, 25))
        d.text((xx + 112, 760), emoji, font=_load(48), fill="white", anchor="mm")
        d.text((xx + 112, 820), lbl, font=_load(30), fill="white", anchor="mm")
        d.text((xx + 112, 865), size, font=_load(26), fill=(255, 255, 255, 170), anchor="mm")

    # bottom nav
    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "home_cleanup.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 2 – whatsapp_manager
# =====================================================================
def shot_whatsapp_manager():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "WhatsApp Media Manager")

    d.text((80, 280), "WhatsApp belegt 4,2 GB", font=_load(38), fill="white")

    filters = [("Alle", True), ("Duplikate", False), ("Große Dateien", False), ("Nach Datum", False)]
    for i, (lbl, active) in enumerate(filters):
        xx = 60 + i * 255
        if active:
            _rrect(d, (xx, 350, xx + 220, 395), 16, fill="white")
            d.text((xx + 110, 372), lbl, font=_load(28), fill=C1, anchor="mm")
        else:
            _rrect(d, (xx, 350, xx + 220, 395), 16, fill=(255, 255, 255, 30))
            d.text((xx + 110, 372), lbl, font=_load(28), fill="white", anchor="mm")

    # file list
    files = [
        ("📸", "IMG_20240721.jpg", "2,4 MB", "Gestern"),
        ("🎥", "VID_20240720.mp4", "45 MB", "20.07.2024"),
        ("📸", "IMG_20240719.jpg", "1,8 MB", "19.07.2024"),
        ("📸", "IMG_20240719.jpg", "1,8 MB", "19.07.2024 ⚠️ Duplikat"),
        ("📄", "Dokument.pdf", "12 MB", "15.07.2024"),
    ]
    for i, (emoji, name, size, date) in enumerate(files):
        yy = 440 + i * 120
        _card(d, 60, yy, W - 120, 100, fill=(255, 255, 255, 25))
        d.text((120, yy + 50), emoji, font=_load(36), fill="white", anchor="mm")
        d.text((180, yy + 30), name, font=_load(28), fill="white")
        d.text((180, yy + 65), size, font=_load(24), fill=(255, 255, 255, 150))
        d.text((W - 120, yy + 50), date, font=_load(24), fill=(255, 255, 255, 150), anchor="mm")
        if "Duplikat" in date:
            _rrect(d, (W - 260, yy + 15, W - 180, yy + 45), 8, fill=(255, 60, 60, 150))

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "whatsapp_manager.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 3 – duplicate_finder
# =====================================================================
def shot_duplicate_finder():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Duplikate-Erkennung")

    d.text((80, 280), "Gefundene Duplikate", font=_load(38), fill="white")
    d.text((80, 330), "17 Gruppen | 42 Dateien | 680 MB", font=_load(28), fill=(255, 255, 255, 170))

    dup_types = [("Datei-Duplikate", "230 MB", 8), ("Ähnliche Bilder", "340 MB", 5), ("Ähnliche Videos", "110 MB", 4)]
    for i, (lbl, sz, cnt) in enumerate(dup_types):
        yy = 400 + i * 200
        _card(d, 60, yy, W - 120, 170, fill=(255, 255, 255, 25))
        d.text((150, yy + 40), lbl, font=_load(34), fill="white")
        d.text((150, yy + 90), f"{cnt} Gruppen · {sz}", font=_load(28), fill=(255, 255, 255, 170))

        # progress bar
        _rrect(d, (150, yy + 130, 650, yy + 144), 7, fill=(255, 255, 255, 30))
        _rrect(d, (150, yy + 130, 150 + int(500 * (i + 1) / 4), yy + 144), 7, fill=(255, 255, 255, 150))

        btn_fill = "white" if i == 0 else (255, 255, 255, 50)
        txt_col = C1 if i == 0 else "white"
        _rrect(d, (W - 220, yy + 50, W - 100, yy + 110), 16, fill=btn_fill)
        d.text((W - 160, yy + 80), "Anzeigen", font=_load(26), fill=txt_col, anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "duplicate_finder.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 4 – file_browser
# =====================================================================
def shot_file_browser():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Datei-Browser")

    cats = [
        ("📷", "Bilder", "1.234", "1,2 GB", (100, 150, 255)),
        ("🎬", "Videos", "156", "8,5 GB", (255, 100, 100)),
        ("🎵", "Audio", "432", "3,1 GB", (100, 255, 150)),
        ("📄", "Dokumente", "89", "0,8 GB", (200, 150, 255)),
        ("📦", "APKs", "12", "0,4 GB", (255, 200, 100)),
    ]
    for i, (emoji, lbl, cnt, sz, col) in enumerate(cats):
        yy = 280 + i * 190
        _card(d, 80, yy, W - 160, 160, fill=(255, 255, 255, 25))

        # small accent bar
        _rrect(d, (80, yy, 90, yy + 160), 4, fill=col)

        d.text((160, yy + 40), emoji, font=_load(48), fill="white", anchor="mm")
        d.text((240, yy + 40), lbl, font=_load(36), fill="white")
        d.text((240, yy + 90), f"{cnt} Dateien", font=_load(28), fill=(255, 255, 255, 170))
        d.text((W - 150, yy + 60), sz, font=_load(32), fill="white", anchor="mm")
        d.text((W - 150, yy + 100), ">", font=_load(32), fill=(255, 255, 255, 150), anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "file_browser.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 5 – compression
# =====================================================================
def shot_compression():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Kompressions-Tool")

    # before / after comparison
    _card(d, 60, 280, W - 120, 200, fill=(255, 255, 255, 25))
    d.text((W // 2 - 200, 330), "Vorher", font=_load(36), fill=(255, 255, 255, 160), anchor="mm")
    d.text((W // 2 + 200, 330), "Nachher", font=_load(36), fill=(255, 255, 255, 160), anchor="mm")
    d.text((W // 2 - 200, 390), "12,4 MB", font=_load(48), fill=(255, 150, 150), anchor="mm")
    d.text((W // 2 + 200, 390), "4,8 MB", font=_load(48), fill=(150, 255, 150), anchor="mm")
    d.text((W // 2, 330), "→", font=_load(40), fill="white", anchor="mm")

    # arrow down savings
    d.text((W // 2, 450), "−61%  (7,6 MB gespart)", font=_load(32), fill=(150, 255, 150), anchor="mm")

    # quality slider
    _card(d, 60, 520, W - 120, 140, fill=(255, 255, 255, 25))
    d.text((150, 560), "Qualität", font=_load(34), fill="white")
    _rrect(d, (150, 610, W - 150, 625), 8, fill=(255, 255, 255, 30))
    _rrect(d, (150, 610, 550, 625), 8, fill=(255, 255, 255, 150))
    d.ellipse([(540, 602), (560, 633)], fill="white")
    d.text((W - 150, 615), "75%", font=_load(28), fill="white", anchor="mm")

    # compressible files
    files = [
        ("IMG_20240721.jpg", "4,2 MB → 1,1 MB"),
        ("VID_20240720.mp4", "45 MB → 18 MB"),
        ("Dokument.pdf", "12 MB → 5,2 MB"),
        ("Foto_Urlaub.png", "8,2 MB → 2,8 MB"),
    ]
    for i, (name, change) in enumerate(files):
        yy = 700 + i * 100
        _card(d, 60, yy, W - 120, 80, fill=(255, 255, 255, 20))
        d.text((140, yy + 40), name, font=_load(26), fill="white", anchor="lm")
        d.text((W - 120, yy + 40), change, font=_load(24), fill=(150, 255, 150), anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "compression.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 6 – junk_cleaner
# =====================================================================
def shot_junk_cleaner():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Junk-Cleaner")

    # total found
    _card(d, 60, 280, W - 120, 150, fill=(255, 255, 255, 25))
    d.text((W // 2, 330), "1,8 GB Junk gefunden", font=_load(42), fill="white", anchor="mm")
    d.text((W // 2, 385), "Bereinige dein Gerät für mehr Speicher", font=_load(28), fill=(255, 255, 255, 160), anchor="mm")

    junk_items = [
        ("🗑", "App-Cache", "850 MB", True),
        ("📁", "Temporäre Dateien", "420 MB", True),
        ("📂", "Leere Ordner", "34 Ordner", True),
        ("📱", "Nicht mehr benötigte APKs", "280 MB", True),
        ("🔄", "System-Cache", "120 MB", True),
        ("📸", "Miniaturansichten-Cache", "98 MB", False),
    ]
    for i, (emoji, lbl, sz, checked) in enumerate(junk_items):
        yy = 470 + i * 120
        _card(d, 60, yy, W - 120, 95, fill=(255, 255, 255, 25))
        d.text((120, yy + 48), emoji, font=_load(36), fill="white", anchor="mm")
        d.text((180, yy + 35), lbl, font=_load(30), fill="white")
        d.text((180, yy + 70), sz, font=_load(26), fill=(255, 255, 255, 150))

        # checkbox
        if checked:
            _rrect(d, (W - 170, yy + 28, W - 110, yy + 68), 10, fill=(255, 255, 255, 150))
            d.text((W - 140, yy + 48), "✓", font=_load(30), fill="white", anchor="mm")
        else:
            _rrect(d, (W - 170, yy + 28, W - 110, yy + 68), 10, fill=(255, 255, 255, 20))

    _rrect(d, (W // 2 - 120, H - 200, W // 2 + 120, H - 130), 24, fill="white")
    d.text((W // 2, H - 165), "Jetzt reinigen", font=_load(32), fill=C1, anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "junk_cleaner.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 7 – settings
# =====================================================================
def shot_settings():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Einstellungen")

    items = [
        ("🌙", "Dark Mode", "AN"),
        ("🌐", "Sprache", "DE"),
        ("🔒", "Sichere Löschung", "AUS"),
        ("♻", "Automatische Reinigung", "Wöchentlich"),
        ("📁", "Standard-Suchpfad", "Interner Speicher"),
        ("🔔", "Benachrichtigungen", "AN"),
        ("📊", "Datenschutz", "100% offline"),
    ]
    for i, (icon, label, val) in enumerate(items):
        yy = 300 + i * 150
        _card(d, 80, yy, W - 160, 110, fill=(255, 255, 255, 25))
        d.text((140, yy + 55), icon, font=_load(40), fill="white", anchor="mm")
        d.text((210, yy + 55), label, font=_load(34), fill="white", anchor="lm")
        if val in ["AN", "AUS"]:
            on = val == "AN"
            _rrect(d, (W - 200, yy + 38, W - 120, yy + 72), 16, fill=(255, 255, 255, 100) if on else (255, 255, 255, 30))
            if on:
                d.ellipse([(W - 190, yy + 42), (W - 166, yy + 68)], fill="white")
            else:
                d.ellipse([(W - 154, yy + 42), (W - 130, yy + 68)], fill=(200, 200, 200))
        else:
            d.text((W - 150, yy + 55), val, font=_load(30), fill=(255, 255, 255, 180), anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "settings.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# SCREENSHOT 8 – privacy
# =====================================================================
def shot_privacy():
    img = Image.new("RGB", (W, H), C1)
    d = ImageDraw.Draw(img)
    _gradient(d, W, H, C1, C2)
    _header_bar(d, "Tidy", "Datenschutz")

    # shield icon
    d.text((W // 2, 320), "🔒", font=_load(120), fill="white", anchor="mm")

    points = [
        "✓  100% offline – Deine Dateien verlassen nie dein Gerät",
        "✓  Keine Datei-Erhebung – Wir sammeln keine Daten",
        "✓  Kein Tracking – Keine Analyse-Tools eingebettet",
        "✓  Open Source – Vollständig einsehbarer Quellcode",
        "✓  Keine Werbung – Ununterbrochene Nutzung",
        "✓  Verschlüsselte Löschung – SSO-Standard",
    ]
    for i, pt in enumerate(points):
        yy = 450 + i * 80
        d.text((120, yy), pt, font=_load(30), fill="white")

    _card(d, 120, 940, W - 240, 100, fill=(255, 255, 255, 20))
    d.text((W // 2, 990), "Version 1.5.2", font=_load(32), fill=(255, 255, 255, 160), anchor="mm")

    _card(d, 120, 1070, W - 240, 100, fill=(255, 255, 255, 20))
    d.text((W // 2, 1120), "MIT License", font=_load(32), fill=(255, 255, 255, 160), anchor="mm")

    _card(d, 0, H - 110, W, 110, r=0, fill=(0, 0, 0, 80))
    nav = ["🏠", "📂", "🎯", "⚙️"]
    for i, n in enumerate(nav):
        d.text((W // 8 + i * W // 4, H - 55), n, font=_load(36), fill="white", anchor="mm")

    fp = os.path.join(OUT, "privacy.png")
    img.save(fp, "PNG", optimize=True)
    print(fp)

# =====================================================================
# MAIN
# =====================================================================
if __name__ == "__main__":
    for fn in [shot_home_cleanup, shot_whatsapp_manager, shot_duplicate_finder,
               shot_file_browser, shot_compression, shot_junk_cleaner,
               shot_settings, shot_privacy]:
        fn()
    print("✅ Tidy screenshots generated in", OUT)
