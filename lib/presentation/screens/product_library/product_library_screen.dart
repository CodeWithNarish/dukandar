// lib/presentation/screens/product_library/product_library_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../providers/calculator_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';
import '../../widgets/common/unit_selector.dart';

class ProductLibraryScreen extends ConsumerStatefulWidget {
  const ProductLibraryScreen({super.key});

  @override
  ConsumerState<ProductLibraryScreen> createState() => _ProductLibraryScreenState();
}

class _ProductLibraryScreenState extends ConsumerState<ProductLibraryScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  static const List<String> _categories = [
    'All', 'Rice', 'Sugar', 'Oil', 'Milk', 'Vegetables', 'Fruits',
    'Dry Fruits', 'Medicine', 'Hardware', 'Stationery', 'Custom',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';
    final productsAsync = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('prod_lib', lang)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocalizationHelper.translate('search_products', lang),
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() { _searchQuery = ''; });
                          },
                        )
                      : null,
                ),
                onChanged: (val) {
                  setState(() { _searchQuery = val; });
                },
              ),
            ),

            // Category filter chips
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() { _selectedCategory = cat; });
                      },
                      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? theme.colorScheme.primary : null,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // Product list
            Expanded(
              child: productsAsync.when(
                data: (allProducts) {
                  // Apply search + category filters
                  var filtered = allProducts.where((p) {
                    final matchesSearch = _searchQuery.isEmpty ||
                        p.name.toLowerCase().contains(_searchQuery.toLowerCase());
                    final matchesCategory = _selectedCategory == 'All' ||
                        p.category == _selectedCategory;
                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 64,
                                color: isDark ? Colors.white24 : Colors.black12),
                            const SizedBox(height: 16),
                            Text(
                              LocalizationHelper.translate('no_products', lang),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final catColor = AppColors.getCategoryColor(product.category);

                      return Dismissible(
                        key: Key('product_${product.id}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete_rounded, color: Colors.red),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(LocalizationHelper.translate('delete', lang)),
                              content: Text(LocalizationHelper.translate('delete_confirm', lang)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text(LocalizationHelper.translate('cancel', lang)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(LocalizationHelper.translate('delete', lang),
                                      style: const TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (_) {
                          ref.read(productListProvider.notifier).deleteProduct(product.id);
                          HapticHelper.heavyImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(LocalizationHelper.translate('product_deleted', lang))),
                          );
                        },
                        child: PremiumCard(
                          glassmorphic: true,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          onTap: () {
                            ref.read(priceToWeightCalculatorProvider.notifier).prefillFromProduct(product);
                            ref.read(productListProvider.notifier).incrementUsage(product.id);
                            context.push('/price-to-weight');
                          },
                          child: Row(
                            children: [
                              // Category color dot
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: catColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 14),
                              // Name + price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '₹${product.price}/${product.unit}',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Favorite star
                              IconButton(
                                icon: Icon(
                                  product.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                                  color: product.isFavorite ? Colors.orange : (isDark ? Colors.white30 : Colors.black26),
                                ),
                                onPressed: () {
                                  ref.read(productListProvider.notifier).toggleFavorite(product.id);
                                  HapticHelper.lightImpact();
                                },
                              ),
                            ],
                          ),
                        ),
                      ).animate()
                       .fadeIn(delay: (index * 30).ms, duration: 200.ms)
                       .slideX(begin: 0.05);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddProductSheet(context, lang),
        icon: const Icon(Icons.add),
        label: Text(LocalizationHelper.translate('add_product', lang)),
      ),
    );
  }

  void _showAddProductSheet(BuildContext context, String lang, {ProductModel? editProduct}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    String name = editProduct?.name ?? '';
    String category = editProduct?.category ?? 'Custom';
    double price = editProduct?.price ?? 0;
    String unit = editProduct?.unit ?? 'KG';
    double baseQty = editProduct?.baseQuantity ?? 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20, right: 20, top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 36, height: 5,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black12,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    editProduct != null
                        ? LocalizationHelper.translate('edit_product', lang)
                        : LocalizationHelper.translate('add_product', lang),
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  PremiumTextField(
                    label: LocalizationHelper.translate('name', lang),
                    initialValue: name,
                    onChanged: (val) => name = val,
                  ),
                  const SizedBox(height: 12),

                  // Category dropdown
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
                    child: Text(
                      LocalizationHelper.translate('category', lang),
                      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: category,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    items: _categories.where((c) => c != 'All').map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (val) {
                      setSheetState(() { category = val ?? 'Custom'; });
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: PremiumTextField(
                          label: LocalizationHelper.translate('price', lang),
                          prefix: '₹',
                          initialValue: price > 0 ? price.toStringAsFixed(0) : '',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (val) => price = double.tryParse(val) ?? 0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: UnitSelector(
                          label: LocalizationHelper.translate('unit', lang),
                          selected: unit,
                          onChanged: (val) {
                            setSheetState(() { unit = val; });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  PremiumTextField(
                    label: LocalizationHelper.translate('base_quantity', lang),
                    initialValue: baseQty.toStringAsFixed(0),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) => baseQty = double.tryParse(val) ?? 1,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (name.isEmpty) return;

                      final product = editProduct ?? ProductModel();
                      product.name = name;
                      product.category = category;
                      product.price = price;
                      product.unit = unit;
                      product.baseQuantity = baseQty;
                      if (editProduct == null) {
                        product.createdAt = DateTime.now();
                      }

                      if (editProduct != null) {
                        ref.read(productListProvider.notifier).updateProduct(product);
                      } else {
                        ref.read(productListProvider.notifier).addProduct(product);
                      }

                      HapticHelper.mediumImpact();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(LocalizationHelper.translate('product_saved', lang))),
                      );
                    },
                    child: Text(LocalizationHelper.translate('save', lang)),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
