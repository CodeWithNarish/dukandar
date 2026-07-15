// lib/data/models/settings_model.dart

import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement;

  String themeMode = 'system'; // 'system' | 'light' | 'dark'
  
  String language = 'en'; // 'en' | 'hi'
  
  bool autoSaveHistory = true;
}
