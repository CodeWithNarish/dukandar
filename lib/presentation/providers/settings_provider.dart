// lib/presentation/providers/settings_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../core/database/isar_service.dart';
import '../../data/models/settings_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/history_model.dart';
import '../../data/models/shop_profile_model.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<SettingsModel> build() async {
    return _fetch();
  }

  Future<SettingsModel> _fetch() async {
    final settings = await IsarService.isar.settingsModels.where().findFirst();
    if (settings != null) return settings;
    
    // Fallback if not seeded
    final newSettings = SettingsModel();
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingsModels.put(newSettings);
    });
    return newSettings;
  }

  Future<void> updateThemeMode(String mode) async {
    final settings = await _fetch();
    settings.themeMode = mode;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingsModels.put(settings);
    });
    ref.invalidateSelf();
  }

  Future<void> updateLanguage(String lang) async {
    final settings = await _fetch();
    settings.language = lang;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingsModels.put(settings);
    });
    ref.invalidateSelf();
  }

  Future<void> updateAutoSaveHistory(bool value) async {
    final settings = await _fetch();
    settings.autoSaveHistory = value;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingsModels.put(settings);
    });
    ref.invalidateSelf();
  }

  Future<void> resetApplication() async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.clear();
      await IsarService.isar.productModels.clear();
      await IsarService.isar.shopProfileModels.clear();
      await IsarService.isar.settingsModels.clear();
    });
    // Re-seed defaults
    final defaultSettings = SettingsModel();
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingsModels.put(defaultSettings);
    });
    ref.invalidateSelf();
  }
}
