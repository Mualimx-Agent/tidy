/// App-Cache Info
class AppCache {
  final String packageName;
  final String appName;
  final int sizeBytes;
  final String? iconPath;

  const AppCache({
    required this.packageName,
    required this.appName,
    required this.sizeBytes,
    this.iconPath,
  });

  String get sizeFormatted {
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    if (sizeBytes < 1024 * 1024 * 1024) return '${(sizeBytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(sizeBytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}
