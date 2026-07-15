// lib/presentation/screens/profit_calculator/profit_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../core/utils/calculation_engine.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';

class ProfitCalculatorScreen extends ConsumerStatefulWidget {
  const ProfitCalculatorScreen({super.key});

  @override
  ConsumerState<ProfitCalculatorScreen> createState() => _ProfitCalculatorScreenState();
}

class _ProfitCalculatorScreenState extends ConsumerState<ProfitCalculatorScreen> {
  double _costPrice = 0.0;
  double _sellingPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    final result = CalculationEngine.calculateProfit(
      costPrice: _costPrice,
      sellingPrice: _sellingPrice,
    );

    final showResult = _costPrice > 0 || _sellingPrice > 0;
    
    // Choose status colors
    final statusColor = result.isProfit 
        ? (isDark ? Colors.greenAccent : Colors.green)
        : (isDark ? Colors.redAccent : Colors.red);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('profit_calc', lang)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cost Price Input
              PremiumTextField(
                label: LocalizationHelper.translate('cost_price', lang),
                prefix: '₹ ',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  setState(() {
                    _costPrice = NumberFormatter.parseDouble(val);
                  });
                },
              ),
              const SizedBox(height: 16),

              // Selling Price Input
              PremiumTextField(
                label: LocalizationHelper.translate('selling_price', lang),
                prefix: '₹ ',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  setState(() {
                    _sellingPrice = NumberFormatter.parseDouble(val);
                  });
                },
              ),
              const SizedBox(height: 28),

              // Result display section
              if (showResult)
                PremiumCard(
                  color: statusColor.withOpacity(isDark ? 0.08 : 0.05),
                  glassmorphic: true,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocalizationHelper.translate('profit_margin', lang),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          Icon(
                            result.isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                            color: statusColor,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        NumberFormatter.formatCurrency(result.profitAmount),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result.isProfit 
                            ? (lang == 'hi' ? 'मुनाफा हुआ है' : 'Net Profit')
                            : (lang == 'hi' ? 'नुकसान हुआ है' : 'Net Loss'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: statusColor.withOpacity(0.8),
                        ),
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
                                  result.isProfit 
                                      ? (lang == 'hi' ? 'मुनाफा %' : 'Profit %')
                                      : (lang == 'hi' ? 'नुकसान %' : 'Loss %'),
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${result.profitPercent.toStringAsFixed(1)}%',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: theme.dividerColor,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalizationHelper.translate('margin_percent', lang),
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${result.marginPercent.toStringAsFixed(1)}%',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
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
