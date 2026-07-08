/// Cluster von Duplikat-Dateien (gleicher Hash)
class DuplicateCluster {
  final String hash;
  final int sizeBytes;
  final List<DuplicateFile> files;
  final String mimeType;

  const DuplicateCluster({
    required this.hash,
    required this.sizeBytes,
    required this.files,
    required this.mimeType,
  });

  int get count => files.length;
  int get totalWastedBytes => sizeBytes * (count - 1); // Alle außer dem Original
  String get totalWastedFormatted => _formatBytes(totalWastedBytes);

  static String _formatBytes(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}

class DuplicateFile {
  final String path;
  final String name;
  final int sizeBytes;
  final DateTime modifiedAt;
  final String? thumbnailPath;
  final bool isSelected;

  const DuplicateFile({
    required this.path,
    required this.name,
    required this.sizeBytes,
    required this.modifiedAt,
    this.thumbnailPath,
    this.isSelected = false,
  });

  DuplicateFile copyWith({bool? isSelected}) => DuplicateFile(
    path: path,
    name: name,
    sizeBytes: sizeBytes,
    modifiedAt: modifiedAt,
    thumbnailPath: thumbnailPath,
    isSelected: isSelected ?? this.isSelected,
  );
}
