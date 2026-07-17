// lib/core/database/land_db.dart
// Simple land field storage using JSON in localStorage (web) or in-memory (native).
// Uses conditional imports to avoid dart:html on non-web builds.

import 'dart:convert';
import 'land_db_storage.dart'; // conditional import shim
import '../../data/models/land_field_model.dart';

class LandDb {
  static final LandDb _instance = LandDb._internal();
  factory LandDb() => _instance;
  LandDb._internal();

  static const _fieldsKey = 'dukandar_land_fields';
  static const _settingsKey = 'dukandar_land_settings';

  // ---- Internal helpers ----

  List<LandFieldModel> _parseFields(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list.map((item) => LandFieldModel(
        id: item['id'] as int,
        fieldName: item['fieldName'] as String? ?? '',
        length1: (item['length1'] as num?)?.toDouble() ?? (item['length'] as num?)?.toDouble() ?? 0,
        length2: (item['length2'] as num?)?.toDouble() ?? (item['length'] as num?)?.toDouble() ?? 0,
        width1: (item['width1'] as num?)?.toDouble() ?? (item['width'] as num?)?.toDouble() ?? 0,
        width2: (item['width2'] as num?)?.toDouble() ?? (item['width'] as num?)?.toDouble() ?? 0,
        measurementUnit: item['measurementUnit'] as String? ?? 'feet',
        localUnit: item['localUnit'] as String? ?? 'bigha',
        conversionValue: (item['conversionValue'] as num).toDouble(),
        areaSqFt: (item['areaSqFt'] as num).toDouble(),
        localUnitArea: (item['localUnitArea'] as num).toDouble(),
        isFavorite: item['isFavorite'] as bool? ?? false,
        notes: item['notes'] as String? ?? '',
        createdAt: DateTime.parse(item['createdAt'] as String),
      )).toList();
    } catch (e) {
      return [];
    }
  }

  String _encodeFields(List<LandFieldModel> fields) {
    return jsonEncode(fields.map((f) => {
      'id': f.id,
      'fieldName': f.fieldName,
      'length1': f.length1,
      'length2': f.length2,
      'width1': f.width1,
      'width2': f.width2,
      'measurementUnit': f.measurementUnit,
      'localUnit': f.localUnit,
      'conversionValue': f.conversionValue,
      'areaSqFt': f.areaSqFt,
      'localUnitArea': f.localUnitArea,
      'isFavorite': f.isFavorite,
      'notes': f.notes,
      'createdAt': f.createdAt.toIso8601String(),
    }).toList());
  }

  // ---- CRUD API ----

  Future<List<LandFieldModel>> getFields() async {
    return _parseFields(LandStorage.read(_fieldsKey));
  }

  Future<LandFieldModel> saveField(LandFieldModel field) async {
    final fields = await getFields();
    if (field.id == 0) {
      field.id = DateTime.now().millisecondsSinceEpoch;
    }
    fields.removeWhere((f) => f.id == field.id);
    fields.insert(0, field);
    LandStorage.write(_fieldsKey, _encodeFields(fields));
    return field;
  }

  Future<bool> deleteField(int id) async {
    final fields = await getFields();
    final before = fields.length;
    fields.removeWhere((f) => f.id == id);
    LandStorage.write(_fieldsKey, _encodeFields(fields));
    return fields.length < before;
  }

  Future<void> toggleFavorite(int id) async {
    final fields = await getFields();
    final idx = fields.indexWhere((f) => f.id == id);
    if (idx >= 0) {
      fields[idx].isFavorite = !fields[idx].isFavorite;
      LandStorage.write(_fieldsKey, _encodeFields(fields));
    }
  }

  Future<void> updateNotes(int id, String notes) async {
    final fields = await getFields();
    final idx = fields.indexWhere((f) => f.id == id);
    if (idx >= 0) {
      fields[idx].notes = notes;
      LandStorage.write(_fieldsKey, _encodeFields(fields));
    }
  }

  // ---- Settings ----

  Future<Map<String, dynamic>> getLandSettings() async {
    final raw = LandStorage.read(_settingsKey);
    if (raw == null || raw.isEmpty) {
      return {
        'conversionValue': 27225.0,
        'localUnit': 'bigha',
        'measurementUnit': 'feet',
      };
    }
    try {
      return Map<String, dynamic>.from(jsonDecode(raw) as Map);
    } catch (_) {
      return {
        'conversionValue': 27225.0,
        'localUnit': 'bigha',
        'measurementUnit': 'feet',
      };
    }
  }

  Future<void> saveLandSettings(Map<String, dynamic> settings) async {
    LandStorage.write(_settingsKey, jsonEncode(settings));
  }
}
