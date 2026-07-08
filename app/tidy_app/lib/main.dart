import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/settings_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const ProviderScope(child: TidyApp()));
}

class TidyApp extends ConsumerWidget {
  const TidyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(routerProvider);

    ThemeMode themeMode;
    switch (settings.themeMode) {
      case 'light': themeMode = ThemeMode.light; break;
      case 'dark': themeMode = ThemeMode.dark; break;
      default: themeMode = ThemeMode.system;
    }

    return MaterialApp.router(
      title: 'Tidy',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
