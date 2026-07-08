import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class MediaAnalysisScreen extends ConsumerWidget {
  const MediaAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final mediaAsync = ref.watch(mediaAnalysisProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Messenger-Medien' : 'Messenger media'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: mediaAsync.when(
        data: (media) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Hero Card
            Card(
              color: AppColors.accent.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('💬', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isDe ? 'WhatsApp & Telegram' : 'WhatsApp & Telegram',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                isDe ? 'Speicherverbrauch:' : 'Storage used:',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      media.totalFormatted,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Counts
            Row(
              children: [
                Expanded(child: _StatTile(
                  icon: '🖼️',
                  value: '${media.photoCount}',
                  label: isDe ? 'Fotos' : 'Photos',
                )),
                const SizedBox(width: 8),
                Expanded(child: _StatTile(
                  icon: '🎬',
                  value: '${media.videoCount}',
                  label: isDe ? 'Videos' : 'Videos',
                )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _StatTile(
                  icon: '🎞️',
                  value: '${media.gifCount}',
                  label: isDe ? 'GIFs' : 'GIFs',
                )),
                const SizedBox(width: 8),
                Expanded(child: _StatTile(
                  icon: '🎤',
                  value: '${media.voiceNoteCount}',
                  label: isDe ? 'Sprachnachr.' : 'Voice notes',
                )),
              ],
            ),
            const SizedBox(height: 24),

            // Insights
            Text(
              isDe ? 'Erkenntnisse' : 'Insights',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),

            _InsightCard(
              emoji: '⏰',
              titleDe: 'Alte Medien',
              titleEn: 'Old media',
              value: media.oldFormatted,
              descriptionDe: 'Medien, die älter als 1 Jahr sind.',
              descriptionEn: 'Media older than 1 year.',
              isDe: isDe,
            ),
            const SizedBox(height: 8),
            _InsightCard(
              emoji: '↗️',
              titleDe: 'Weitergeleitet',
              titleEn: 'Forwarded',
              value: media.forwardsFormatted,
              descriptionDe: 'Medien, die du nur weitergeleitet hast.',
              descriptionEn: 'Media you only forwarded.',
              isDe: isDe,
            ),
            const SizedBox(height: 24),

            // By Contact
            Text(
              isDe ? 'Nach Kontakt' : 'By contact',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            ...media.byContact.entries.map((e) {
              final percent = e.value / media.totalMediaBytes;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key, style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            _format(e.value),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percent,
                          minHeight: 8,
                          backgroundColor: AppColors.surfaceVariant,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(percent * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  static String _format(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}

class _StatTile extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _StatTile({required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String emoji;
  final String titleDe;
  final String titleEn;
  final String value;
  final String descriptionDe;
  final String descriptionEn;
  final bool isDe;

  const _InsightCard({
    required this.emoji,
    required this.titleDe,
    required this.titleEn,
    required this.value,
    required this.descriptionDe,
    required this.descriptionEn,
    required this.isDe,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 32)),
        title: Text(isDe ? titleDe : titleEn),
        subtitle: Text(isDe ? descriptionDe : descriptionEn),
        trailing: Text(
          value,
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
