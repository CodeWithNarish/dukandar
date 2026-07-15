// lib/core/database/web_db_impl.dart

import 'dart:convert';
import 'dart:html' as html;
import '../../data/models/product_model.dart';
import '../../data/models/history_model.dart';
import '../../data/models/shop_profile_model.dart';
import '../../data/models/settings_model.dart';

class WebDbMock {
  final ProductCollection productModels = ProductCollection();
  final HistoryCollection historyModels = HistoryCollection();
  final ShopProfileCollection shopProfileModels = ShopProfileCollection();
  final SettingsCollection settingsModels = SettingsCollection();

  Future<void> initialize() async {
    print("🌐 Web LocalStorage Database Mock Initialized");
  }

  Future<T> writeTxn<T>(Future<T> Function() callback) async {
    return await callback();
  }
}

class ProductCollection {
  List<ProductModel> _load() {
    final data = html.window.localStorage['dukandar_products'];
    if (data == null) return [];
    try {
      final list = jsonDecode(data) as List;
      return list.map((item) {
        final p = ProductModel()
          ..id = item['id'] as int
          ..name = item['name'] as String
          ..category = item['category'] as String
          ..price = (item['price'] as num).toDouble()
          ..unit = item['unit'] as String
          ..baseQuantity = (item['baseQuantity'] as num).toDouble()
          ..isFavorite = item['isFavorite'] as bool
          ..createdAt = DateTime.parse(item['createdAt'] as String)
          ..useCount = item['useCount'] as int;
        if (item['lastUsedAt'] != null) {
          p.lastUsedAt = DateTime.parse(item['lastUsedAt'] as String);
        }
        return p;
      }).toList();
    } catch (e) {
      print('Error parsing products: $e');
      return [];
    }
  }

  void _save(List<ProductModel> items) {
    final list = items.map((item) => {
      'id': item.id,
      'name': item.name,
      'category': item.category,
      'price': item.price,
      'unit': item.unit,
      'baseQuantity': item.baseQuantity,
      'isFavorite': item.isFavorite,
      'createdAt': item.createdAt.toIso8601String(),
      'lastUsedAt': item.lastUsedAt?.toIso8601String(),
      'useCount': item.useCount,
    }).toList();
    html.window.localStorage['dukandar_products'] = jsonEncode(list);
  }

  Future<ProductModel?> get(int id) async {
    final list = _load();
    for (final item in list) {
      if (item.id == id) return item;
    }
    return null;
  }

  ProductQueryWhere where() {
    return ProductQueryWhere(_load());
  }

  Future<int> put(ProductModel product) async {
    final list = _load();
    if (product.id == 0 || product.id == -5593817549870564352) {
      product.id = DateTime.now().millisecondsSinceEpoch;
    }
    list.removeWhere((item) => item.id == product.id);
    list.add(product);
    _save(list);
    return product.id;
  }

  Future<bool> delete(int id) async {
    final list = _load();
    final initialLen = list.length;
    list.removeWhere((item) => item.id == id);
    _save(list);
    return list.length < initialLen;
  }

  Future<void> clear() async {
    _save([]);
  }

  Future<int> count() async {
    return _load().length;
  }
}

class ProductQueryWhere {
  final List<ProductModel> _items;
  ProductQueryWhere(this._items);

  Future<List<ProductModel>> findAll() async {
    return _items;
  }

  Future<ProductModel?> findFirst() async {
    return _items.isEmpty ? null : _items.first;
  }

  ProductQueryFilter filter() {
    return ProductQueryFilter(_items);
  }
}

class ProductQueryFilter {
  final List<ProductModel> _items;
  ProductQueryFilter(this._items);

  ProductQueryFilter isFavoriteEqualTo(bool value) {
    return ProductQueryFilter(_items.where((item) => item.isFavorite == value).toList());
  }

  Future<List<ProductModel>> findAll() async {
    return _items;
  }
}

class HistoryCollection {
  List<HistoryModel> _load() {
    final data = html.window.localStorage['dukandar_history'];
    if (data == null) return [];
    try {
      final list = jsonDecode(data) as List;
      return list.map((item) {
        final h = HistoryModel()
          ..id = item['id'] as int
          ..productName = item['productName'] as String?
          ..calculationType = item['calculationType'] as String
          ..inputPrice = (item['inputPrice'] as num).toDouble()
          ..inputQuantity = (item['inputQuantity'] as num).toDouble()
          ..unit = item['unit'] as String
          ..inputAmount = (item['inputAmount'] as num).toDouble()
          ..resultValue = (item['resultValue'] as num).toDouble()
          ..timestamp = DateTime.parse(item['timestamp'] as String)
          ..linkedProductId = item['linkedProductId'] as int?;
        return h;
      }).toList();
    } catch (e) {
      print('Error parsing history: $e');
      return [];
    }
  }

  void _save(List<HistoryModel> items) {
    final list = items.map((item) => {
      'id': item.id,
      'productName': item.productName,
      'calculationType': item.calculationType,
      'inputPrice': item.inputPrice,
      'inputQuantity': item.inputQuantity,
      'unit': item.unit,
      'inputAmount': item.inputAmount,
      'resultValue': item.resultValue,
      'timestamp': item.timestamp.toIso8601String(),
      'linkedProductId': item.linkedProductId,
    }).toList();
    html.window.localStorage['dukandar_history'] = jsonEncode(list);
  }

  Future<HistoryModel?> get(int id) async {
    final list = _load();
    for (final item in list) {
      if (item.id == id) return item;
    }
    return null;
  }

  HistoryQueryWhere where() {
    return HistoryQueryWhere(_load());
  }

  Future<int> put(HistoryModel entry) async {
    final list = _load();
    if (entry.id == 0 || entry.id == 5151902556644193280) {
      entry.id = DateTime.now().millisecondsSinceEpoch;
    }
    list.removeWhere((item) => item.id == entry.id);
    list.add(entry);
    _save(list);
    return entry.id;
  }

  Future<bool> delete(int id) async {
    final list = _load();
    final initialLen = list.length;
    list.removeWhere((item) => item.id == id);
    _save(list);
    return list.length < initialLen;
  }

  Future<void> clear() async {
    _save([]);
  }

  Future<int> count() async {
    return _load().length;
  }
}

class HistoryQueryWhere {
  final List<HistoryModel> _items;
  HistoryQueryWhere(this._items);

  Future<List<HistoryModel>> findAll() async {
    return _items;
  }

  Future<HistoryModel?> findFirst() async {
    return _items.isEmpty ? null : _items.first;
  }
}

class ShopProfileCollection {
  List<ShopProfileModel> _load() {
    final data = html.window.localStorage['dukandar_profile'];
    if (data == null) return [];
    try {
      final list = jsonDecode(data) as List;
      return list.map((item) {
        final p = ShopProfileModel()
          ..id = item['id'] as int
          ..shopName = item['shopName'] as String
          ..ownerName = item['ownerName'] as String
          ..defaultCurrency = item['defaultCurrency'] as String
          ..defaultWeightUnit = item['defaultWeightUnit'] as String
          ..logoPath = item['logoPath'] as String?;
        return p;
      }).toList();
    } catch (e) {
      print('Error parsing shop profile: $e');
      return [];
    }
  }

  void _save(List<ShopProfileModel> items) {
    final list = items.map((item) => {
      'id': item.id,
      'shopName': item.shopName,
      'ownerName': item.ownerName,
      'defaultCurrency': item.defaultCurrency,
      'defaultWeightUnit': item.defaultWeightUnit,
      'logoPath': item.logoPath,
    }).toList();
    html.window.localStorage['dukandar_profile'] = jsonEncode(list);
  }

  ShopProfileQueryWhere where() {
    return ShopProfileQueryWhere(_load());
  }

  Future<int> put(ShopProfileModel profile) async {
    final list = _load();
    if (profile.id == 0 || profile.id == 4881038503994177536) {
      profile.id = DateTime.now().millisecondsSinceEpoch;
    }
    list.removeWhere((item) => item.id == profile.id);
    list.add(profile);
    _save(list);
    return profile.id;
  }

  Future<void> clear() async {
    _save([]);
  }

  Future<int> count() async {
    return _load().length;
  }
}

class ShopProfileQueryWhere {
  final List<ShopProfileModel> _items;
  ShopProfileQueryWhere(this._items);

  Future<List<ShopProfileModel>> findAll() async {
    return _items;
  }

  Future<ShopProfileModel?> findFirst() async {
    return _items.isEmpty ? null : _items.first;
  }
}

class SettingsCollection {
  List<SettingsModel> _load() {
    final data = html.window.localStorage['dukandar_settings'];
    if (data == null) return [];
    try {
      final list = jsonDecode(data) as List;
      return list.map((item) {
        final s = SettingsModel()
          ..id = item['id'] as int
          ..themeMode = item['themeMode'] as String
          ..language = item['language'] as String
          ..autoSaveHistory = item['autoSaveHistory'] as bool;
        return s;
      }).toList();
    } catch (e) {
      print('Error parsing settings: $e');
      return [];
    }
  }

  void _save(List<SettingsModel> items) {
    final list = items.map((item) => {
      'id': item.id,
      'themeMode': item.themeMode,
      'language': item.language,
      'autoSaveHistory': item.autoSaveHistory,
    }).toList();
    html.window.localStorage['dukandar_settings'] = jsonEncode(list);
  }

  SettingsQueryWhere where() {
    return SettingsQueryWhere(_load());
  }

  Future<int> put(SettingsModel settings) async {
    final list = _load();
    if (settings.id == 0 || settings.id == 4013777327486952960) {
      settings.id = DateTime.now().millisecondsSinceEpoch;
    }
    list.removeWhere((item) => item.id == settings.id);
    list.add(settings);
    _save(list);
    return settings.id;
  }

  Future<void> clear() async {
    _save([]);
  }

  Future<int> count() async {
    return _load().length;
  }
}

class SettingsQueryWhere {
  final List<SettingsModel> _items;
  SettingsQueryWhere(this._items);

  Future<List<SettingsModel>> findAll() async {
    return _items;
  }

  Future<SettingsModel?> findFirst() async {
    return _items.isEmpty ? null : _items.first;
  }
}
