// lib/presentation/providers/land_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/land_db.dart';
import '../../data/models/land_field_model.dart';

// ---- Land Fields List Provider ----
class LandFieldsNotifier extends AsyncNotifier<List<LandFieldModel>> {
  @override
  Future<List<LandFieldModel>> build() async {
    return await LandDb().getFields();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => LandDb().getFields());
  }

  Future<void> saveField(LandFieldModel field) async {
    await LandDb().saveField(field);
    await refresh();
  }

  Future<void> deleteField(int id) async {
    await LandDb().deleteField(id);
    await refresh();
  }

  Future<void> toggleFavorite(int id) async {
    await LandDb().toggleFavorite(id);
    await refresh();
  }

  Future<void> updateNotes(int id, String notes) async {
    await LandDb().updateNotes(id, notes);
    await refresh();
  }
}

final landFieldsProvider = AsyncNotifierProvider<LandFieldsNotifier, List<LandFieldModel>>(
  LandFieldsNotifier.new,
);

// ---- Land Settings Provider ----
class LandSettingsNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    return await LandDb().getLandSettings();
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await LandDb().saveLandSettings(settings);
    state = AsyncValue.data(settings);
  }
}

final landSettingsProvider = AsyncNotifierProvider<LandSettingsNotifier, Map<String, dynamic>>(
  LandSettingsNotifier.new,
);

// ---- Favorite Fields Provider ----
final favoriteLandFieldsProvider = Provider<AsyncValue<List<LandFieldModel>>>((ref) {
  final fieldsAsync = ref.watch(landFieldsProvider);
  return fieldsAsync.whenData((fields) =>
    fields.where((f) => f.isFavorite).toList()
  );
});
