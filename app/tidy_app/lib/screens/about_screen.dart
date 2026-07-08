import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Über Tidy' : 'About Tidy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(child: Text('✨', style: TextStyle(fontSize: 64))),
          const SizedBox(height: 16),
          Center(child: Text('Tidy', style: Theme.of(context).textTheme.displayMedium)),
          Center(child: Text('v1.0.0', style: Theme.of(context).textTheme.bodyMedium)),
          const SizedBox(height: 32),

          _SectionLabel(text: isDe ? 'Unsere Werte' : 'Our values'),
          _Bullet(text: isDe ? '100% lokal, 0 Cloud, 0 Tracker' : '100% local, 0 cloud, 0 trackers'),
          _Bullet(text: isDe ? 'Open Source (Apache 2.0)' : 'Open source (Apache 2.0)'),
          _Bullet(text: isDe ? 'Keine Werbung' : 'No advertising'),
          _Bullet(text: isDe ? 'Faire Preise (Einmalkauf, kein Abo)' : 'Fair pricing (one-time, no subscription)'),
          _Bullet(text: isDe ? 'Sichere Vorschau vor jedem Löschen' : 'Safe preview before every deletion'),
          const SizedBox(height: 24),

          _SectionLabel(text: isDe ? 'Was wir NICHT machen' : 'What we DON\'T do'),
          _Bullet(text: isDe ? 'Keine Datei-Uploads in die Cloud' : 'No file uploads to the cloud'),
          _Bullet(text: isDe ? 'Keine Tracker oder Analytics' : 'No trackers or analytics'),
          _Bullet(text: isDe ? 'Keine versteckten Berechtigungen' : 'No hidden permissions'),
          _Bullet(text: isDe ? 'Keine Datenweitergabe an Dritte' : 'No data sharing with third parties'),
          const SizedBox(height: 24),

          _SectionLabel(text: isDe ? 'Kontakt' : 'Contact'),
          _Bullet(text: 'mail2mualimx@gmail.com'),
          const SizedBox(height: 32),

          Center(
            child: Text(
              isDe ? 'Mit Sorgfalt gebaut von Mualimx Apps' : 'Built with care by Mualimx Apps',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: AppColors.primary, fontSize: 16)),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
