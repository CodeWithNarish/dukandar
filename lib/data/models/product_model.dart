// lib/data/models/product_model.dart

import 'package:isar/isar.dart';

part 'product_model.g.dart';

@collection
class ProductModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  @Index()
  late String category;

  late double price;

  late String unit;

  late double baseQuantity;

  @Index()
  bool isFavorite = false;

  late DateTime createdAt;

  DateTime? lastUsedAt;

  int useCount = 0;
}
