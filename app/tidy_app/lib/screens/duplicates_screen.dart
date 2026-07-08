import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class DuplicatesScreen extends ConsumerWidget {
  const DuplicatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final duplicatesAsync = ref.watch(duplicatesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Duplikate' : 'Duplicates'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: duplicatesAsync.when(
        data: (clusters) {
          if (clusters.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  isDe
                      ? '🎉 Keine Duplikate gefunden!\n\nDein Speicher ist sauber.'
                      : '🎉 No duplicates found!\n\nYour storage is clean.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          final totalWasted = clusters.fold<int>(0, (sum, c) => sum + c.totalWastedBytes);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                color: AppColors.accent.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text('💾', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isDe ? 'Du kannst freigeben:' : 'You can free:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              _formatBytes(totalWasted),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.accent,
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
              ...clusters.map((cluster) => _ClusterCard(cluster: cluster, isDe: isDe)),
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

class _ClusterCard extends StatelessWidget {
  final dynamic cluster; // DuplicateCluster
  final bool isDe;

  const _ClusterCard({required this.cluster, required this.isDe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Row(
          children: [
            Text(
              cluster.mimeType.startsWith('video') ? '🎬' : '🖼️',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cluster.count}x ${cluster.sizeBytes ~/ 1024 ~/ 1024} MB',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${cluster.totalWastedFormatted} ${isDe ? "verschwendet" : "wasted"}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: cluster.files.map<Widget>((file) {
          return ListTile(
            leading: const Icon(Icons.image_outlined),
            title: Text(
              file.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(file.path, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isDe
                          ? 'Demo: In Production öffnet sich SAF-Dateimanager zur sicheren Löschung.'
                          : 'Demo: In production, SAF file picker opens for safe deletion.',
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
