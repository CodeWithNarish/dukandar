// lib/presentation/screens/price_to_weight/price_to_weight_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/history_model.dart';
import '../../providers/calculator_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/history_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';
import '../../widgets/common/unit_selector.dart';
import '../../widgets/common/result_display.dart';

class PriceToWeightScreen extends ConsumerStatefulWidget {
  const PriceToWeightScreen({super.key});

  @override
  ConsumerState<PriceToWeightScreen> createState() => _PriceToWeightScreenState();
}

class _PriceToWeightScreenState extends ConsumerState<PriceToWeightScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _baseQtyController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  List<ProductModel> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _baseQtyController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Save to history on navigation back if values are valid
  void _saveToHistoryOnPop(PriceToWeightState state) {
    final settingsAsync = ref.read(settingsNotifierProvider);
    final autoSave = settingsAsync.value?.autoSaveHistory ?? true;
    
    if (autoSave && state.price > 0 && state.customerAmount > 0 && state.result > 0) {
      final entry = HistoryModel()
        ..productName = state.productName.isEmpty ? 'Price → Weight Calc' : state.productName
        ..calculationType = 'price_to_weight'
        ..inputPrice = state.price
        ..inputQuantity = state.baseQuantity
        ..unit = state.unit
        ..inputAmount = state.customerAmount
        ..resultValue = state.result
        ..timestamp = DateTime.now();

      ref.read(historyListProvider.notifier).addHistoryEntry(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    final state = ref.watch(priceToWeightCalculatorProvider);
    final notifier = ref.read(priceToWeightCalculatorProvider.notifier);

    // Sync controllers with state if state changes from favorite prefill
    ref.listen(priceToWeightCalculatorProvider, (previous, next) {
      if (previous?.productName != next.productName && _nameController.text != next.productName) {
        _nameController.text = next.productName;
      }
      if (previous?.price != next.price && next.price > 0 && _priceController.text != next.price.toString()) {
        _priceController.text = next.price == next.price.roundToDouble() 
            ? next.price.toStringAsFixed(0) 
            : next.price.toString();
      }
      if (previous?.baseQuantity != next.baseQuantity && _baseQtyController.text != next.baseQuantity.toString()) {
        _baseQtyController.text = next.baseQuantity == next.baseQuantity.roundToDouble()
            ? next.baseQuantity.toStringAsFixed(0)
            : next.baseQuantity.toString();
      }
    });

    final double pricePerGramOrUnit = state.price / (state.unit == 'KG' || state.unit == 'Litre' ? 1000 : 1);
    final String formulaString = state.unit == 'KG' || state.unit == 'Litre'
        ? '₹${state.price} ÷ 1000g = ₹${pricePerGramOrUnit.toStringAsFixed(4)} per gram\n'
            '₹${state.customerAmount} ÷ ₹${pricePerGramOrUnit.toStringAsFixed(4)} = ${NumberFormatter.formatResult(state.result, 'Gram')} Gram'
        : '₹${state.price} ÷ ${state.baseQuantity} = ₹${(state.price / state.baseQuantity).toStringAsFixed(2)} per ${state.unit}\n'
            '₹${state.customerAmount} ÷ ₹${(state.price / state.baseQuantity).toStringAsFixed(2)} = ${NumberFormatter.formatResult(state.result, state.unit)} ${state.unit}';

    return WillPopScope(
      onWillPop: () async {
        _saveToHistoryOnPop(state);
        notifier.reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizationHelper.translate('price_to_weight', lang)),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_add_outlined),
              onPressed: () => _saveAsProduct(context, state, lang),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name Input + Autocomplete Suggestions
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            _showSuggestions = hasFocus && _suggestions.isNotEmpty;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PremiumTextField(
                              controller: _nameController,
                              label: LocalizationHelper.translate('product_name', lang),
                              hint: LocalizationHelper.translate('product_name_hint', lang),
                              onChanged: (val) async {
                                notifier.updateProductName(val);
                                if (val.isEmpty) {
                                  setState(() {
                                    _suggestions = [];
                                    _showSuggestions = false;
                                  });
                                } else {
                                  final searchResults = await ref
                                      .read(productListProvider.notifier)
                                      .search(val);
                                  setState(() {
                                    _suggestions = searchResults;
                                    _showSuggestions = _suggestions.isNotEmpty;
                                  });
                                }
                              },
                            ),
                            if (_showSuggestions) ...[
                              const SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkSurface : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                  ),
                                ),
                                constraints: const BoxConstraints(maxHeight: 180),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _suggestions.length,
                                  itemBuilder: (context, index) {
                                    final product = _suggestions[index];
                                    return ListTile(
                                      title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      subtitle: Text('₹${product.price}/${product.unit}'),
                                      onTap: () {
                                        notifier.prefillFromProduct(product);
                                        _nameController.text = product.name;
                                        _priceController.text = product.price.toStringAsFixed(0);
                                        _baseQtyController.text = product.baseQuantity.toStringAsFixed(0);
                                        setState(() {
                                          _showSuggestions = false;
                                        });
                                        HapticHelper.selectionClick();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price Input
                      PremiumTextField(
                        controller: _priceController,
                        label: LocalizationHelper.translate('product_price', lang),
                        prefix: '₹ ',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (val) {
                          notifier.updatePrice(NumberFormatter.parseDouble(val));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Unit Selector + Base Quantity
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: UnitSelector(
                              label: LocalizationHelper.translate('unit', lang),
                              selected: state.unit,
                              onChanged: (val) {
                                notifier.updateUnit(val);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: PremiumTextField(
                              controller: _baseQtyController,
                              label: LocalizationHelper.translate('base_quantity', lang),
                              initialValue: state.baseQuantity == 1.0 ? '1' : state.baseQuantity.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (val) {
                                notifier.updateBaseQuantity(double.tryParse(val) ?? 1.0);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Customer Amount Input (Autofocus to capture quick input)
                      PremiumTextField(
                        controller: _amountController,
                        label: LocalizationHelper.translate('customer_amount', lang),
                        prefix: '₹ ',
                        autofocus: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (val) {
                          notifier.updateCustomerAmount(NumberFormatter.parseDouble(val));
                        },
                      ),
                      const SizedBox(height: 28),

                      // Result Display (Live Calculation Output)
                      if (state.price > 0 && state.customerAmount > 0)
                        ResultCard(
                          value: state.result,
                          unit: state.unit,
                          formula: formulaString,
                        ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.97, 0.97)),
                    ],
                  ),
                ),
              ),

              // Bottom Control Bar
              if (state.price > 0 && state.customerAmount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                    border: Border(
                      top: BorderSide(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            HapticHelper.mediumImpact();
                            final resultStr = state.unit == 'KG' || state.unit == 'Litre'
                                ? '${NumberFormatter.formatResult(state.result, 'Gram')} Gram'
                                : '${NumberFormatter.formatResult(state.result, state.unit)} ${state.unit}';
                            Clipboard.setData(ClipboardData(text: resultStr));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(LocalizationHelper.translate('copy_clipboard', lang)),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy_rounded),
                          label: Text(lang == 'hi' ? 'कॉपी करें' : 'Copy Result'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            HapticHelper.mediumImpact();
                            _saveToHistoryOnPop(state);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(lang == 'hi' ? 'हिसाब सेव हो गया!' : 'Calculation saved to history!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.history_edu_rounded),
                          label: Text(lang == 'hi' ? 'हिसाब सेव' : 'Save History'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 1.0, duration: 200.ms),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAsProduct(BuildContext context, PriceToWeightState state, String lang) {
    if (state.productName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang == 'hi' ? 'सामान का नाम दर्ज करें' : 'Enter a product name first')),
      );
      return;
    }

    final product = ProductModel()
      ..name = state.productName
      ..price = state.price
      ..unit = state.unit
      ..baseQuantity = state.baseQuantity
      ..category = 'Custom'
      ..createdAt = DateTime.now();

    ref.read(productListProvider.notifier).addProduct(product);
    HapticHelper.mediumImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocalizationHelper.translate('product_saved', lang))),
    );
  }
}
