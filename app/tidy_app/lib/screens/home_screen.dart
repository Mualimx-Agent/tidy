import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final statsAsync = ref.watch(storageStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Tidy' : 'Tidy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(storageStatsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Storage-Übersicht
              statsAsync.when(
                data: (stats) => _StorageCard(stats: stats, isDe: isDe),
                loading: () => const _LoadingCard(),
                error: (e, _) => _ErrorCard(error: e.toString()),
              ),
              const SizedBox(height: 24),

              // Scan-Optionen
              Text(
                isDe ? 'Speicher scannen' : 'Scan storage',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),

              _ScanCard(
                icon: '🔍',
                titleDe: 'Duplikate',
                titleEn: 'Duplicates',
                subtitleDe: 'Gleiche Dateien mehrfach gefunden',
                subtitleEn: 'Same files found multiple times',
                onTap: () => context.push('/duplicates'),
                isDe: isDe,
              ),
              const SizedBox(height: 12),
              _ScanCard(
                icon: '📦',
                titleDe: 'Große Dateien',
                titleEn: 'Large files',
                subtitleDe: 'Dateien über ${settings.largeFileThresholdMB} MB',
                subtitleEn: 'Files over ${settings.largeFileThresholdMB} MB',
                onTap: () => context.push('/large-files'),
                isDe: isDe,
              ),
              const SizedBox(height: 12),
              _ScanCard(
                icon: '🗑️',
                titleDe: 'App-Caches',
                titleEn: 'App caches',
                subtitleDe: 'Temporäre Daten anderer Apps',
                subtitleEn: 'Temporary data from other apps',
                onTap: () => context.push('/app-caches'),
                isDe: isDe,
              ),
              const SizedBox(height: 12),
              _ScanCard(
                icon: '💬',
                titleDe: 'WhatsApp & Telegram',
                titleEn: 'WhatsApp & Telegram',
                subtitleDe: 'Medien-Analyse der Messenger',
                subtitleEn: 'Messenger media analysis',
                onTap: () => context.push('/media'),
                isDe: isDe,
                highlight: true,
              ),
              const SizedBox(height: 24),

              // Pro Banner
              Card(
                color: AppColors.accent.withValues(alpha: 0.15),
                child: ListTile(
                  leading: const Text('✨', style: TextStyle(fontSize: 32)),
                  title: Text(
                    isDe ? 'Tidy Pro' : 'Tidy Pro',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    isDe
                        ? 'Batch-Komprimierung, Auto-Cleanup, alle Features. Einmal €9.99.'
                        : 'Batch compression, auto-cleanup, all features. Once €9.99.',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(isDe
                          ? 'In v1.1 verfügbar. Aktuell noch ohne Payment.'
                          : 'Available in v1.1. Currently without payment.')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorageCard extends StatelessWidget {
  final dynamic stats;
  final bool isDe;
  const _StorageCard({required this.stats, required this.isDe});

  @override
  Widget build(BuildContext context) {
    final score = stats.healthScore;
    final color = score >= 60
        ? AppColors.success
        : score >= 30
            ? AppColors.warning
            : AppColors.error;

    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDe ? 'Speicher' : 'Storage',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${stats.healthScore}/100',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${stats.usedFormatted} / ${stats.totalFormatted}',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${stats.freeFormatted} ${isDe ? "frei" : "free"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: stats.usedPercent,
                minHeight: 12,
                backgroundColor: color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(stats.usedPercent * 100).toStringAsFixed(1)}% ${isDe ? "belegt" : "used"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;
  const _ErrorCard({required this.error});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text('Error: $error'),
      ),
    );
  }
}

class _ScanCard extends StatelessWidget {
  final String icon;
  final String titleDe;
  final String titleEn;
  final String subtitleDe;
  final String subtitleEn;
  final VoidCallback onTap;
  final bool isDe;
  final bool highlight;

  const _ScanCard({
    required this.icon,
    required this.titleDe,
    required this.titleEn,
    required this.subtitleDe,
    required this.subtitleEn,
    required this.onTap,
    required this.isDe,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: highlight ? AppColors.accent.withValues(alpha: 0.1) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDe ? titleDe : titleEn,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isDe ? subtitleDe : subtitleEn,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
