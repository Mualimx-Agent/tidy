import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  final String language; // 'de', 'en'
  final String themeMode; // 'system', 'light', 'dark'
  final int largeFileThresholdMB; // Default 50
  final bool onboardingCompleted;

  const AppSettings({
    this.language = 'de',
    this.themeMode = 'system',
    this.largeFileThresholdMB = 50,
    this.onboardingCompleted = false,
  });

  AppSettings copyWith({
    String? language,
    String? themeMode,
    int? largeFileThresholdMB,
    bool? onboardingCompleted,
  }) =>
      AppSettings(
        language: language ?? this.language,
        themeMode: themeMode ?? this.themeMode,
        largeFileThresholdMB: largeFileThresholdMB ?? this.largeFileThresholdMB,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      );
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  static const _key = 'app_settings';

  SettingsNotifier() : super(const AppSettings()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final map = <String, String>{};
      for (final pair in raw.split(';')) {
        final parts = pair.split('=');
        if (parts.length == 2) map[parts[0]] = parts[1];
      }
      state = AppSettings(
        language: map['language'] ?? 'de',
        themeMode: map['themeMode'] ?? 'system',
        largeFileThresholdMB: int.tryParse(map['largeFileThresholdMB'] ?? '50') ?? 50,
        onboardingCompleted: map['onboardingCompleted'] == 'true',
      );
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final s = state;
    await prefs.setString(_key,
      'language=${s.language};'
      'themeMode=${s.themeMode};'
      'largeFileThresholdMB=${s.largeFileThresholdMB};'
      'onboardingCompleted=${s.onboardingCompleted}');
  }

  Future<void> setLanguage(String lang) async {
    state = state.copyWith(language: lang);
    await _save();
  }

  Future<void> setThemeMode(String mode) async {
    state = state.copyWith(themeMode: mode);
    await _save();
  }

  Future<void> setLargeFileThreshold(int mb) async {
    state = state.copyWith(largeFileThresholdMB: mb);
    await _save();
  }

  Future<void> setOnboardingCompleted(bool done) async {
    state = state.copyWith(onboardingCompleted: done);
    await _save();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(),
);
