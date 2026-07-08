import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class AppCachesScreen extends ConsumerWidget {
  const AppCachesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final cachesAsync = ref.watch(appCachesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'App-Caches' : 'App caches'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: cachesAsync.when(
        data: (caches) {
          if (caches.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  isDe
                      ? 'Keine App-Caches gefunden.'
                      : 'No app caches found.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          final total = caches.fold<int>(0, (sum, c) => sum + c.sizeBytes);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                color: AppColors.warning.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text('🗑️', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isDe ? 'Cache-Größe gesamt:' : 'Total cache size:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              _formatBytes(total),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isDe
                                  ? 'Hinweis: Cache-Löschung erfordert System-Berechtigung.\nIn Production öffnen wir die System-Einstellungen.'
                                  : 'Note: Cache clearing requires system permission.\nIn production, we open system settings.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...caches.map((cache) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.surfaceVariant,
                    child: Icon(Icons.android, color: AppColors.primary),
                  ),
                  title: Text(cache.appName),
                  subtitle: Text(cache.packageName, style: const TextStyle(fontSize: 11)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        cache.sizeFormatted,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.warning,
                        ),
                      ),
                      Text(
                        isDe ? 'Cache' : 'cache',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isDe
                              ? 'Demo: System-Einstellungen würden sich öffnen.'
                              : 'Demo: System settings would open.',
                        ),
                      ),
                    );
                  },
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
