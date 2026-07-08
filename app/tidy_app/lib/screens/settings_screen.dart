import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isDe ? 'Einstellungen' : 'Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionLabel(text: isDe ? 'Sprache' : 'Language'),
          Card(
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Deutsch'),
                  value: 'de',
                  groupValue: settings.language,
                  onChanged: (v) => v != null ? notifier.setLanguage(v) : null,
                ),
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: settings.language,
                  onChanged: (v) => v != null ? notifier.setLanguage(v) : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _SectionLabel(text: isDe ? 'Erscheinungsbild' : 'Appearance'),
          Card(
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text(isDe ? 'System' : 'System'),
                  value: 'system',
                  groupValue: settings.themeMode,
                  onChanged: (v) => v != null ? notifier.setThemeMode(v) : null,
                ),
                RadioListTile<String>(
                  title: Text(isDe ? 'Hell' : 'Light'),
                  value: 'light',
                  groupValue: settings.themeMode,
                  onChanged: (v) => v != null ? notifier.setThemeMode(v) : null,
                ),
                RadioListTile<String>(
                  title: Text(isDe ? 'Dunkel' : 'Dark'),
                  value: 'dark',
                  groupValue: settings.themeMode,
                  onChanged: (v) => v != null ? notifier.setThemeMode(v) : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _SectionLabel(text: isDe ? 'Schwellenwert' : 'Threshold'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDe ? 'Große Dateien ab' : 'Large files from',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${settings.largeFileThresholdMB} MB',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: settings.largeFileThresholdMB.toDouble(),
                    min: 10,
                    max: 500,
                    divisions: 49,
                    label: '${settings.largeFileThresholdMB} MB',
                    onChanged: (v) => notifier.setLargeFileThreshold(v.round()),
                  ),
                  Text(
                    isDe
                        ? 'Dateien über diesem Schwellenwert werden als „groß" markiert.'
                        : 'Files above this threshold are marked as "large".',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(isDe ? 'Über Tidy' : 'About Tidy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push('/about'),
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
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary),
      ),
    );
  }
}
