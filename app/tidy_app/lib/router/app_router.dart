import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';
import '../screens/duplicates_screen.dart';
import '../screens/large_files_screen.dart';
import '../screens/app_caches_screen.dart';
import '../screens/media_analysis_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsProvider);
  return GoRouter(
    initialLocation: settings.onboardingCompleted ? '/home' : '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/duplicates', builder: (_, __) => const DuplicatesScreen()),
      GoRoute(path: '/large-files', builder: (_, __) => const LargeFilesScreen()),
      GoRoute(path: '/app-caches', builder: (_, __) => const AppCachesScreen()),
      GoRoute(path: '/media', builder: (_, __) => const MediaAnalysisScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/about', builder: (_, __) => const AboutScreen()),
    ],
  );
});
