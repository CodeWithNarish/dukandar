// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteProductsHash() => r'73380eb770f48a3c4c0afd4cc0eeade1bf6ed3d6';

/// See also [favoriteProducts].
@ProviderFor(favoriteProducts)
final favoriteProductsProvider =
    AutoDisposeFutureProvider<List<ProductModel>>.internal(
  favoriteProducts,
  name: r'favoriteProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteProductsRef = AutoDisposeFutureProviderRef<List<ProductModel>>;
String _$productListHash() => r'5e7aee66509c41da9f5c03e9826957ddd980d32c';

/// See also [ProductList].
@ProviderFor(ProductList)
final productListProvider =
    AutoDisposeAsyncNotifierProvider<ProductList, List<ProductModel>>.internal(
  ProductList.new,
  name: r'productListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductList = AutoDisposeAsyncNotifier<List<ProductModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
