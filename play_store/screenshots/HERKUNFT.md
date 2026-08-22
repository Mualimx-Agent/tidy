# Herkunft dieser Screenshots — und eine ernste Einschraenkung

Aufgenommen am 22.08.2026 aus der **laufenden Anwendung**: Flutter-Web-Build von
Tidy, gesteuert ueber das Chrome DevTools Protocol. Sichtbereich 360x800
logisch, beim Aufnehmen per `clip.scale = 3` auf 1080x2400 Bildpunkte
hochskaliert. Werkzeug: `~/shoot2.py`.

Es ist derselbe Dart-Code und dasselbe Theme wie in der Android-App. Kein Bild
ist gezeichnet.

## ⛔ Diese Screenshots duerfen NICHT in den Play Store

Nicht weil die Bilder unecht waeren — sondern weil die **Zahlen darin erfunden**
sind. `lib/services/storage_scanner.dart` scannt nichts:

- `// Simuliert: 128 GB Total, 92 GB Used (72%)` — fest im Code, Zeile 75-78
- `photoCount: 8420` — fest im Code, Zeile 227
- 16 Aufrufe von `_demoStorageStats()` / `_demoDuplicates()` /
  `_demoLargeFiles()` / `_demoAppCaches()` in einer 274-Zeilen-Datei
- **Kein einziger Datei-System-Zugriff.** `photo_manager` und
  `permission_handler` stehen in der `pubspec.yaml`, werden aber nirgends
  aufgerufen — sie kommen nur in Kommentaren vor (`// TODO: photo_manager
  Integration`).
- Auch der Mobil-Pfad endet in `return _demoStorageStats()`. Der `kIsWeb`-Zweig
  ist also nicht die Ursache — die App hat schlicht keinen Scanner.

Jedes Telefon wuerde exakt `92.00 GB / 128.00 GB` und `8420 Fotos` anzeigen.
Eine Aufraeum-App, die erfundene Speicherzahlen zeigt und Freigaben verspricht,
faellt unter Googles Richtlinie zu irrefuehrenden Leistungsversprechen.

## Was zuerst passieren muss

1. Echten Scanner bauen: `photo_manager` fuer Medien, `Directory`-Traversierung
   fuer Dateien, `crypto` (ist schon eingebunden) fuer die Duplikat-Hashes.
2. Echtes Loeschen umsetzen — aktuell existiert dafuer keine Implementierung.
3. Danach Screenshots mit echten Geraetedaten neu aufnehmen.

Bis dahin sind diese Bilder nur fuer die eigene Ansicht brauchbar.
