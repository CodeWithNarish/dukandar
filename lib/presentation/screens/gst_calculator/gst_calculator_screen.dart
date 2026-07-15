// lib/presentation/screens/gst_calculator/gst_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../core/utils/calculation_engine.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';

class GstCalculatorScreen extends ConsumerStatefulWidget {
  const GstCalculatorScreen({super.key});

  @override
  ConsumerState<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends ConsumerState<GstCalculatorScreen> {
  double _amount = 0.0;
  double _gstPercent = 18.0;
  bool _isAddMode = true; // true = Add GST, false = Remove GST (inclusive)
  bool _isCustomGst = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    final GSTResult result;
    if (_isAddMode) {
      result = CalculationEngine.calculateGSTAdd(amount: _amount, gstPercent: _gstPercent);
    } else {
      result = CalculationEngine.calculateGSTRemove(inclusiveAmount: _amount, gstPercent: _gstPercent);
    }

    final showResult = _amount > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('gst_calc', lang)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add / Remove Toggle
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAddMode = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: _isAddMode ? theme.colorScheme.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            LocalizationHelper.translate('add_gst', lang),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isAddMode ? Colors.white : (isDark ? Colors.white60 : Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAddMode = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: !_isAddMode ? theme.colorScheme.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            LocalizationHelper.translate('remove_gst', lang),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !_isAddMode ? Colors.white : (isDark ? Colors.white60 : Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Amount input
              PremiumTextField(
                label: LocalizationHelper.translate('amount', lang),
                prefix: '₹ ',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  setState(() {
                    _amount = NumberFormatter.parseDouble(val);
                  });
                },
              ),
              const SizedBox(height: 16),

              // GST % chips
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  LocalizationHelper.translate('gst_percentage', lang),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  ...[5, 12, 18, 28].map((pct) {
                    final isSelected = !_isCustomGst && _gstPercent == pct.toDouble();
                    return ChoiceChip(
                      label: Text('$pct%'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _gstPercent = pct.toDouble();
                          _isCustomGst = false;
                        });
                      },
                      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? theme.colorScheme.primary : null,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }),
                  ChoiceChip(
                    label: const Text('Custom'),
                    selected: _isCustomGst,
                    onSelected: (selected) {
                      setState(() {
                        _isCustomGst = true;
                      });
                    },
                    selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: _isCustomGst ? theme.colorScheme.primary : null,
                      fontWeight: _isCustomGst ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),

              if (_isCustomGst) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: 120,
                  child: PremiumTextField(
                    label: '%',
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        _gstPercent = double.tryParse(val) ?? 0;
                      });
                    },
                  ),
                ),
              ],
              const SizedBox(height: 28),

              // Result Card
              if (showResult)
                PremiumCard(
                  glassmorphic: true,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isAddMode) ...[
                        // Add mode results
                        _ResultRow(
                          label: LocalizationHelper.translate('base_amount', lang),
                          value: NumberFormatter.formatCurrency(result.baseAmount),
                          theme: theme,
                        ),
                        const SizedBox(height: 12),
                        _ResultRow(
                          label: '${LocalizationHelper.translate('gst_value', lang)} (${_gstPercent.toStringAsFixed(0)}%)',
                          value: '+ ${NumberFormatter.formatCurrency(result.gstValue)}',
                          theme: theme,
                          valueColor: Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        _ResultRow(
                          label: LocalizationHelper.translate('total_amount', lang),
                          value: NumberFormatter.formatCurrency(result.finalAmount),
                          theme: theme,
                          isBold: true,
                          valueColor: theme.colorScheme.primary,
                          valueSize: 28,
                        ),
                      ] else ...[
                        // Remove mode results
                        _ResultRow(
                          label: LocalizationHelper.translate('total_amount', lang),
                          value: NumberFormatter.formatCurrency(result.finalAmount),
                          theme: theme,
                        ),
                        const SizedBox(height: 12),
                        _ResultRow(
                          label: '${LocalizationHelper.translate('gst_value', lang)} (${_gstPercent.toStringAsFixed(0)}%)',
                          value: '- ${NumberFormatter.formatCurrency(result.gstValue)}',
                          theme: theme,
                          valueColor: Colors.red,
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        _ResultRow(
                          label: LocalizationHelper.translate('base_amount', lang),
                          value: NumberFormatter.formatCurrency(result.baseAmount),
                          theme: theme,
                          isBold: true,
                          valueColor: theme.colorScheme.primary,
                          valueSize: 28,
                        ),
                      ],
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

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;
  final bool isBold;
  final Color? valueColor;
  final double? valueSize;

  const _ResultRow({
    required this.label,
    required this.value,
    required this.theme,
    this.isBold = false,
    this.valueColor,
    this.valueSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: (isBold ? theme.textTheme.titleLarge : theme.textTheme.titleMedium)?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }
}
