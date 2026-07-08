/// Große Datei (z.B. > 50 MB)
class LargeFile {
  final String path;
  final String name;
  final int sizeBytes;
  final String category; // 'video', 'image', 'audio', 'document', 'archive', 'other'
  final DateTime modifiedAt;
  final String? thumbnailPath;

  const LargeFile({
    required this.path,
    required this.name,
    required this.sizeBytes,
    required this.category,
    required this.modifiedAt,
    this.thumbnailPath,
  });

  String get sizeFormatted {
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    if (sizeBytes < 1024 * 1024 * 1024) return '${(sizeBytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(sizeBytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }

  String get categoryEmoji {
    switch (category) {
      case 'video': return '🎬';
      case 'image': return '🖼️';
      case 'audio': return '🎵';
      case 'document': return '📄';
      case 'archive': return '📦';
      default: return '📁';
    }
  }
}
