// lib/presentation/screens/discount_calculator/discount_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../core/utils/calculation_engine.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';

class DiscountCalculatorScreen extends ConsumerStatefulWidget {
  const DiscountCalculatorScreen({super.key});

  @override
  ConsumerState<DiscountCalculatorScreen> createState() => _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends ConsumerState<DiscountCalculatorScreen> {
  double _originalPrice = 0.0;
  double _discountPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    final result = CalculationEngine.calculateDiscount(
      originalPrice: _originalPrice,
      discountPercent: _discountPercent,
    );

    final showResult = _originalPrice > 0 && _discountPercent > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('discount_calc', lang)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PremiumTextField(
                label: LocalizationHelper.translate('original_price', lang),
                prefix: '₹ ',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  setState(() {
                    _originalPrice = NumberFormatter.parseDouble(val);
                  });
                },
              ),
              const SizedBox(height: 16),

              // Discount Percentage Label
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
                child: Text(
                  LocalizationHelper.translate('discount_percentage', lang),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ),

              // Slider
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _discountPercent.clamp(0, 100),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '${_discountPercent.toInt()}%',
                      activeColor: theme.colorScheme.primary,
                      onChanged: (val) {
                        setState(() {
                          _discountPercent = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 70,
                    child: PremiumTextField(
                      initialValue: _discountPercent.toStringAsFixed(0),
                      suffix: '%',
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          _discountPercent = (double.tryParse(val) ?? 0).clamp(0, 100);
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Quick percent chips
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [5, 10, 15, 20, 25, 30, 50].map((pct) {
                  final isSelected = _discountPercent == pct.toDouble();
                  return ChoiceChip(
                    label: Text('$pct%'),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _discountPercent = pct.toDouble();
                      });
                    },
                    selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.primary : null,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),

              // Result
              if (showResult)
                PremiumCard(
                  glassmorphic: true,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalizationHelper.translate('final_price', lang),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: result.finalPrice),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        builder: (context, val, _) {
                          return Text(
                            NumberFormatter.formatCurrency(val),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang == 'hi' ? 'छूट राशि' : 'Discount Amount',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  NumberFormatter.formatCurrency(result.discountAmount),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 40, color: theme.dividerColor),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalizationHelper.translate('savings', lang),
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  NumberFormatter.formatCurrency(result.savings),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 350.ms).scale(begin: const Offset(0.97, 0.97)),
            ],
          ),
        ),
      ),
    );
  }
}
