import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class LargeFilesScreen extends ConsumerWidget {
  const LargeFilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final filesAsync = ref.watch(largeFilesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Große Dateien' : 'Large files'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: filesAsync.when(
        data: (files) {
          if (files.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  isDe
                      ? 'Keine großen Dateien gefunden.\nAlles unter ${settings.largeFileThresholdMB} MB.'
                      : 'No large files found.\nAll under ${settings.largeFileThresholdMB} MB.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          final total = files.fold<int>(0, (sum, f) => sum + f.sizeBytes);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                color: AppColors.primary.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text('📦', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isDe ? 'Top ${files.length} große Dateien:' : 'Top ${files.length} large files:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              _formatBytes(total),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...files.map((file) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Text(file.categoryEmoji, style: const TextStyle(fontSize: 32)),
                  title: Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    '${file.sizeFormatted}\n${file.path}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isDe
                                ? 'Demo: SAF-Dateimanager öffnet sich zur sicheren Löschung.'
                                : 'Demo: SAF file picker opens for safe deletion.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}
