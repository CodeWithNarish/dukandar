// lib/core/database/isar_service.dart

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:isar/isar.dart';
import '../../data/models/product_model.dart';
import '../../data/models/history_model.dart';
import '../../data/models/shop_profile_model.dart';
import '../../data/models/settings_model.dart';

import 'directory_provider_stub.dart'
    if (dart.library.io) 'directory_provider_native.dart';
import 'web_db_stub.dart'
    if (dart.library.html) 'web_db_impl.dart';

class IsarService {
  static late dynamic isar;

  static Future<void> initialize() async {
    if (kIsWeb) {
      final mockDb = WebDbMock();
      await mockDb.initialize();
      isar = mockDb;
    } else {
      final dirPath = await getDirectoryPath();
      isar = await Isar.open(
        [
          ProductModelSchema,
          HistoryModelSchema,
          ShopProfileModelSchema,
          SettingsModelSchema,
        ],
        directory: dirPath,
        name: 'dukandar_db',
      );
    }

    // Seed defaults
    await _seedDefaults();

    print('✅ Database initialized${kIsWeb ? ' (Web/LocalStorage Mock)' : ''}');
  }

  static Future<void> _seedDefaults() async {
    final settingsCount = await isar.settingsModels.count();
    if (settingsCount == 0) {
      final defaultSettings = SettingsModel();
      await isar.writeTxn(() async {
        await isar.settingsModels.put(defaultSettings);
      });
    }

    final profileCount = await isar.shopProfileModels.count();
    if (profileCount == 0) {
      final defaultProfile = ShopProfileModel()
        ..shopName = 'Dukandar Shop'
        ..ownerName = 'Owner'
        ..defaultCurrency = '₹'
        ..defaultWeightUnit = 'KG'
        ..logoPath = 'logo';
      await isar.writeTxn(() async {
        await isar.shopProfileModels.put(defaultProfile);
      });
    }
  }
}
