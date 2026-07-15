// lib/presentation/providers/shop_profile_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../core/database/isar_service.dart';
import '../../data/models/shop_profile_model.dart';

part 'shop_profile_provider.g.dart';

@riverpod
class ShopProfileNotifier extends _$ShopProfileNotifier {
  @override
  Future<ShopProfileModel> build() async {
    return _fetch();
  }

  Future<ShopProfileModel> _fetch() async {
    final profile = await IsarService.isar.shopProfileModels.where().findFirst();
    if (profile != null) return profile;

    // Fallback if not seeded
    final newProfile = ShopProfileModel()
      ..shopName = 'Dukandar Shop'
      ..ownerName = 'Owner'
      ..defaultCurrency = '₹'
      ..defaultWeightUnit = 'KG';
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.shopProfileModels.put(newProfile);
    });
    return newProfile;
  }

  Future<void> updateProfile({
    required String shopName,
    required String ownerName,
    required String defaultCurrency,
    required String defaultWeightUnit,
    String? logoPath,
  }) async {
    final profile = await _fetch();
    profile.shopName = shopName;
    profile.ownerName = ownerName;
    profile.defaultCurrency = defaultCurrency;
    profile.defaultWeightUnit = defaultWeightUnit;
    profile.logoPath = logoPath;

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.shopProfileModels.put(profile);
    });
    ref.invalidateSelf();
  }
}
