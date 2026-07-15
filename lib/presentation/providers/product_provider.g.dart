// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteProductsHash() => r'5ac59f221d405413b23b23cbc294dee42f233dd1';

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
String _$productListHash() => r'b0bfefd4a47d96fb0b7b9ef1191f658dd93ebd0b';

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
