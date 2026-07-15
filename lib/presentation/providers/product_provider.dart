// lib/presentation/providers/product_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../core/database/isar_service.dart';
import '../../data/models/product_model.dart';

part 'product_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<ProductModel>> build() async {
    return _fetchAll();
  }

  Future<List<ProductModel>> _fetchAll() async {
    final List<ProductModel> results = List<ProductModel>.from(
      await IsarService.isar.productModels.where().findAll()
    );
    // Sort in Dart with explicit types
    results.sort((ProductModel a, ProductModel b) {
      final cmp = (b.lastUsedAt ?? DateTime(1970)).compareTo(a.lastUsedAt ?? DateTime(1970));
      if (cmp != 0) return cmp;
      return b.createdAt.compareTo(a.createdAt);
    });
    return results;
  }

  Future<void> addProduct(ProductModel product) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.put(product);
    });
    ref.invalidateSelf();
  }

  Future<void> updateProduct(ProductModel product) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.put(product);
    });
    ref.invalidateSelf();
  }

  Future<void> deleteProduct(int id) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.delete(id);
    });
    ref.invalidateSelf();
  }

  Future<void> toggleFavorite(int id) async {
    final product = await IsarService.isar.productModels.get(id);
    if (product != null) {
      product.isFavorite = !product.isFavorite;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.productModels.put(product);
      });
      ref.invalidateSelf();
    }
  }

  Future<void> incrementUsage(int id) async {
    final product = await IsarService.isar.productModels.get(id);
    if (product != null) {
      product.useCount += 1;
      product.lastUsedAt = DateTime.now();
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.productModels.put(product);
      });
      ref.invalidateSelf();
    }
  }

  Future<List<ProductModel>> search(String query, {String? category}) async {
    if (query.isEmpty && (category == null || category.isEmpty || category == 'All')) {
      return _fetchAll();
    }

    var results = List<ProductModel>.from(
      await IsarService.isar.productModels.where().findAll()
    );

    // Apply filters in Dart for full compatibility
    results = results.where((p) {
      bool matches = true;
      if (query.isNotEmpty) {
        matches = p.name.toLowerCase().contains(query.toLowerCase());
      }
      if (category != null && category.isNotEmpty && category != 'All') {
        matches = matches && p.category == category;
      }
      return matches;
    }).toList();

    // Sort with explicit types
    results.sort((ProductModel a, ProductModel b) {
      return (b.lastUsedAt ?? DateTime(1970)).compareTo(a.lastUsedAt ?? DateTime(1970));
    });

    return results;
  }
}

@riverpod
Future<List<ProductModel>> favoriteProducts(FavoriteProductsRef ref) async {
  ref.watch(productListProvider);
  
  final results = List<ProductModel>.from(
    await IsarService.isar.productModels
      .where()
      .filter()
      .isFavoriteEqualTo(true)
      .findAll()
  );

  // Sort with explicit types
  results.sort((ProductModel a, ProductModel b) {
    return (b.lastUsedAt ?? DateTime(1970)).compareTo(a.lastUsedAt ?? DateTime(1970));
  });

  return results;
}
