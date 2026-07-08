/// Storage-Statistik (Total, Used, Free)
class StorageStats {
  final int totalBytes;
  final int usedBytes;
  final int freeBytes;

  const StorageStats({
    required this.totalBytes,
    required this.usedBytes,
    required this.freeBytes,
  });

  double get usedPercent => totalBytes > 0 ? usedBytes / totalBytes : 0;
  double get freePercent => 1.0 - usedPercent;

  String get totalFormatted => _formatBytes(totalBytes);
  String get usedFormatted => _formatBytes(usedBytes);
  String get freeFormatted => _formatBytes(freeBytes);

  /// Storage-Health-Score (0-100)
  /// > 30% frei = 100, < 5% frei = 0
  int get healthScore {
    if (freePercent > 0.30) return 100;
    if (freePercent < 0.05) return 0;
    // Linear zwischen 5% und 30%
    return ((freePercent - 0.05) / 0.25 * 100).round().clamp(0, 100);
  }

  String get healthLabel {
    if (healthScore >= 80) return 'Excellent';
    if (healthScore >= 60) return 'Good';
    if (healthScore >= 40) return 'OK';
    if (healthScore >= 20) return 'Tight';
    return 'Critical';
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}
