import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  final _pages = [
    {
      'emoji': '✨',
      'titleDe': 'Willkommen bei Tidy',
      'titleEn': 'Welcome to Tidy',
      'bodyDe': 'Mehr Speicherplatz. In 3 Minuten.\n\nTidy findet Duplikate, große Dateien und App-Caches — und hilft dir, sie sicher zu löschen.',
      'bodyEn': 'More storage. In 3 minutes.\n\nTidy finds duplicates, large files, and app caches — and helps you delete them safely.',
    },
    {
      'emoji': '🔍',
      'titleDe': 'Intelligente Scans',
      'titleEn': 'Smart scans',
      'bodyDe': 'Duplikate per SHA-256-Hash.\nGroße Dateien nach deinem Schwellenwert.\nApp-Caches nach Größe sortiert.\nWhatsApp-Medien tief analysiert.',
      'bodyEn': 'Duplicates via SHA-256 hash.\nLarge files by your threshold.\nApp caches sorted by size.\nWhatsApp media deeply analyzed.',
    },
    {
      'emoji': '🛡️',
      'titleDe': '100% Privat',
      'titleEn': '100% Private',
      'bodyDe': 'Alles läuft auf deinem Gerät.\n\nKeine Cloud. Keine Tracker. Keine Datenweitergabe. Open Source.',
      'bodyEn': 'Everything runs on your device.\n\nNo cloud. No trackers. No data sharing. Open source.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    ref.read(settingsProvider.notifier).setOnboardingCompleted(true);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final isDe = settings.language == 'de';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p['emoji']!, style: const TextStyle(fontSize: 96)),
                        const SizedBox(height: 32),
                        Text(
                          isDe ? p['titleDe']! : p['titleEn']!,
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isDe ? p['bodyDe']! : p['bodyEn']!,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(
                    _page < _pages.length - 1
                        ? (isDe ? 'Weiter' : 'Next')
                        : (isDe ? 'Los geht\'s' : 'Get started'),
                  ),
                ),
              ),
            ),
            if (_page < _pages.length - 1)
              TextButton(
                onPressed: _finish,
                child: Text(isDe ? 'Überspringen' : 'Skip'),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
