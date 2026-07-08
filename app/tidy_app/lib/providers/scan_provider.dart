import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/storage_stats.dart';
import '../models/duplicate_cluster.dart';
import '../models/large_file.dart';
import '../models/app_cache.dart';
import '../services/storage_scanner.dart';

final storageScannerProvider = Provider<StorageScanner>((ref) => StorageScanner());

/// Scan-State (welche Scans laufen / geladen sind)
class ScanState {
  final bool isScanning;
  final String currentScan; // 'stats', 'duplicates', 'large', 'caches', 'media'
  final double progress; // 0.0 - 1.0

  const ScanState({
    this.isScanning = false,
    this.currentScan = '',
    this.progress = 0.0,
  });

  ScanState copyWith({bool? isScanning, String? currentScan, double? progress}) =>
      ScanState(
        isScanning: isScanning ?? this.isScanning,
        currentScan: currentScan ?? this.currentScan,
        progress: progress ?? this.progress,
      );
}

final scanStateProvider = StateNotifierProvider<ScanStateNotifier, ScanState>((ref) {
  return ScanStateNotifier();
});

class ScanStateNotifier extends StateNotifier<ScanState> {
  ScanStateNotifier() : super(const ScanState());

  void start(String scanType) {
    state = state.copyWith(isScanning: true, currentScan: scanType, progress: 0.0);
  }

  void updateProgress(double p) {
    state = state.copyWith(progress: p);
  }

  void stop() {
    state = const ScanState();
  }
}

/// Storage Stats
final storageStatsProvider = FutureProvider<StorageStats>((ref) async {
  final scanner = ref.read(storageScannerProvider);
  return scanner.getStorageStats();
});

/// Duplicates
final duplicatesProvider = FutureProvider<List<DuplicateCluster>>((ref) async {
  final scanner = ref.read(storageScannerProvider);
  ref.read(scanStateProvider.notifier).start('duplicates');
  try {
    final result = await scanner.scanDuplicates();
    return result;
  } finally {
    ref.read(scanStateProvider.notifier).stop();
  }
});

/// Large Files
final largeFilesProvider = FutureProvider<List<LargeFile>>((ref) async {
  final scanner = ref.read(storageScannerProvider);
  ref.read(scanStateProvider.notifier).start('large');
  try {
    return await scanner.scanLargeFiles();
  } finally {
    ref.read(scanStateProvider.notifier).stop();
  }
});

/// App Caches
final appCachesProvider = FutureProvider<List<AppCache>>((ref) async {
  final scanner = ref.read(storageScannerProvider);
  ref.read(scanStateProvider.notifier).start('caches');
  try {
    return await scanner.scanAppCaches();
  } finally {
    ref.read(scanStateProvider.notifier).stop();
  }
});

/// Media Analysis
final mediaAnalysisProvider = FutureProvider<MediaAnalysis>((ref) async {
  final scanner = ref.read(storageScannerProvider);
  ref.read(scanStateProvider.notifier).start('media');
  try {
    return await scanner.analyzeMessagingMedia();
  } finally {
    ref.read(scanStateProvider.notifier).stop();
  }
});
