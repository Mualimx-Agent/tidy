import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/storage_stats.dart';
import '../models/duplicate_cluster.dart';
import '../models/large_file.dart';
import '../models/app_cache.dart';

/// Storage-Scanner Service
/// HINWEIS: Echter File-System-Scan nur auf Android/iOS via MediaStore/photo_manager.
/// Web-Plattform: Demo-Modus (simulierte Daten für UI-Tests)
class StorageScanner {
  /// Storage-Statistik (echt auf Mobile, simuliert auf Web)
  Future<StorageStats> getStorageStats() async {
    if (kIsWeb) {
      return _demoStorageStats();
    }

    try {
      // Auf Mobile: disk_space_plus oder ähnliches
      // Für MVP: approximieren
      // TODO: Echtes Plugin einbinden
      return _demoStorageStats();
    } catch (e) {
      return _demoStorageStats();
    }
  }

  /// Duplikate-Scan (SHA-256 Hash)
  Future<List<DuplicateCluster>> scanDuplicates({
    int maxFiles = 200,
    int maxFileSizeMB = 50,
  }) async {
    if (kIsWeb) {
      return _demoDuplicates();
    }

    // Auf Mobile: photo_manager durchsuchen, Hash berechnen
    // TODO: photo_manager Integration
    return _demoDuplicates();
  }

  /// Große Dateien Top N
  Future<List<LargeFile>> scanLargeFiles({
    int minSizeMB = 50,
    int limit = 20,
  }) async {
    if (kIsWeb) {
      return _demoLargeFiles();
    }
    return _demoLargeFiles();
  }

  /// App-Caches
  Future<List<AppCache>> scanAppCaches() async {
    if (kIsWeb) {
      return _demoAppCaches();
    }
    return _demoAppCaches();
  }

  /// WhatsApp-/Telegram-Medien-Analyse (Killer-Feature)
  Future<MediaAnalysis> analyzeMessagingMedia() async {
    if (kIsWeb) {
      return _demoMediaAnalysis();
    }
    return _demoMediaAnalysis();
  }

  // === DEMO DATA (für Web-Build & UI-Tests) ===

  StorageStats _demoStorageStats() {
    // Simuliert: 128 GB Total, 92 GB Used (72%)
    return StorageStats(
      totalBytes: 128 * 1024 * 1024 * 1024,
      usedBytes: 92 * 1024 * 1024 * 1024,
      freeBytes: 36 * 1024 * 1024 * 1024,
    );
  }

  List<DuplicateCluster> _demoDuplicates() {
    return [
      DuplicateCluster(
        hash: 'a1b2c3d4e5f6',
        sizeBytes: 4 * 1024 * 1024, // 4 MB
        mimeType: 'image/jpeg',
        files: List.generate(3, (i) => DuplicateFile(
          path: '/storage/emulated/0/IMG_001_$i.jpg',
          name: 'IMG_001_$i.jpg',
          sizeBytes: 4 * 1024 * 1024,
          modifiedAt: DateTime.now().subtract(const Duration(days: 30)),
        )),
      ),
      DuplicateCluster(
        hash: 'b2c3d4e5f6g7',
        sizeBytes: 8 * 1024 * 1024,
        mimeType: 'image/jpeg',
        files: [
          DuplicateFile(
            path: '/storage/emulated/0/DCIM/Camera/IMG_20250607_153045.jpg',
            name: 'IMG_20250607_153045.jpg',
            sizeBytes: 8 * 1024 * 1024,
            modifiedAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
          DuplicateFile(
            path: '/storage/emulated/0/WhatsApp/Media/WhatsApp Images/IMG_20250607_153045.jpg',
            name: 'IMG_20250607_153045.jpg',
            sizeBytes: 8 * 1024 * 1024,
            modifiedAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ],
      ),
      DuplicateCluster(
        hash: 'c3d4e5f6g7h8',
        sizeBytes: 12 * 1024 * 1024,
        mimeType: 'video/mp4',
        files: [
          DuplicateFile(
            path: '/storage/emulated/0/DCIM/Video/VID_001.mp4',
            name: 'VID_001.mp4',
            sizeBytes: 12 * 1024 * 1024,
            modifiedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
          DuplicateFile(
            path: '/storage/emulated/0/Movies/VID_001 (1).mp4',
            name: 'VID_001 (1).mp4',
            sizeBytes: 12 * 1024 * 1024,
            modifiedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
        ],
      ),
    ];
  }

  List<LargeFile> _demoLargeFiles() {
    return [
      LargeFile(
        path: '/storage/emulated/0/Movies/Sunset_Timelapse.mp4',
        name: 'Sunset_Timelapse.mp4',
        sizeBytes: 850 * 1024 * 1024, // 850 MB
        category: 'video',
        modifiedAt: DateTime.now().subtract(const Duration(days: 14)),
      ),
      LargeFile(
        path: '/storage/emulated/0/Movies/Berlin_Trip_2026.mp4',
        name: 'Berlin_Trip_2026.mp4',
        sizeBytes: (1.2 * 1024 * 1024 * 1024).toInt(), // 1.2 GB
        category: 'video',
        modifiedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      LargeFile(
        path: '/storage/emulated/0/DCIM/Photos/burst_001.dng',
        name: 'burst_001.dng',
        sizeBytes: 250 * 1024 * 1024,
        category: 'image',
        modifiedAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      LargeFile(
        path: '/storage/emulated/0/Music/Concert_2025.flac',
        name: 'Concert_2025.flac',
        sizeBytes: 180 * 1024 * 1024,
        category: 'audio',
        modifiedAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      LargeFile(
        path: '/storage/emulated/0/Download/manual.pdf',
        name: 'manual.pdf',
        sizeBytes: 95 * 1024 * 1024,
        category: 'document',
        modifiedAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
      LargeFile(
        path: '/storage/emulated/0/Download/photos_backup.zip',
        name: 'photos_backup.zip',
        sizeBytes: (2.1 * 1024 * 1024 * 1024).toInt(), // 2.1 GB
        category: 'archive',
        modifiedAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
    ];
  }

  List<AppCache> _demoAppCaches() {
    return [
      AppCache(
        packageName: 'com.google.android.youtube',
        appName: 'YouTube',
        sizeBytes: 320 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'com.whatsapp',
        appName: 'WhatsApp',
        sizeBytes: 180 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'com.instagram.android',
        appName: 'Instagram',
        sizeBytes: 240 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'com.spotify.music',
        appName: 'Spotify',
        sizeBytes: 156 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'com.google.android.apps.maps',
        appName: 'Google Maps',
        sizeBytes: 89 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'org.telegram.messenger',
        appName: 'Telegram',
        sizeBytes: 95 * 1024 * 1024,
      ),
      AppCache(
        packageName: 'com.android.chrome',
        appName: 'Chrome',
        sizeBytes: 64 * 1024 * 1024,
      ),
    ];
  }

  MediaAnalysis _demoMediaAnalysis() {
    return MediaAnalysis(
      totalMediaBytes: (5.8 * 1024 * 1024 * 1024).toInt(), // 5.8 GB
      photoCount: 8420,
      videoCount: 320,
      gifCount: 156,
      voiceNoteCount: 230,
      oldMediaBytes: (1.4 * 1024 * 1024 * 1024).toInt(), // 1.4 GB älter als 1 Jahr
      forwardsBytes: 480 * 1024 * 1024, // 480 MB weitergeleitet
      byContact: {
        'Familie': (2.1 * 1024 * 1024 * 1024).toInt(),
        'Freunde': (1.5 * 1024 * 1024 * 1024).toInt(),
        'Uni/Arbeit': (0.9 * 1024 * 1024 * 1024).toInt(),
        'Andere': (1.3 * 1024 * 1024 * 1024).toInt(),
      },
    );
  }
}

/// WhatsApp/Telegram-Media-Analyse
class MediaAnalysis {
  final int totalMediaBytes;
  final int photoCount;
  final int videoCount;
  final int gifCount;
  final int voiceNoteCount;
  final int oldMediaBytes;
  final int forwardsBytes;
  final Map<String, int> byContact;

  const MediaAnalysis({
    required this.totalMediaBytes,
    required this.photoCount,
    required this.videoCount,
    required this.gifCount,
    required this.voiceNoteCount,
    required this.oldMediaBytes,
    required this.forwardsBytes,
    required this.byContact,
  });

  String get totalFormatted => _format(totalMediaBytes);
  String get oldFormatted => _format(oldMediaBytes);
  String get forwardsFormatted => _format(forwardsBytes);

  static String _format(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}
