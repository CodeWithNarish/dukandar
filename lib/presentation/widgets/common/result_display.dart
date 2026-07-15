// lib/presentation/widgets/common/result_display.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../providers/settings_provider.dart';

class ResultCard extends ConsumerWidget {
  final double value;
  final String unit;
  final String formula;
  final bool isPriceResult; // true if result is currency (₹), false if result is quantity (e.g. Grams)

  const ResultCard({
    super.key,
    required this.value,
    required this.unit,
    required this.formula,
    this.isPriceResult = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    final label = isPriceResult
        ? LocalizationHelper.translate('result_pay', lang)
        : LocalizationHelper.translate('result_receive', lang);

    final String displayValue = isPriceResult 
        ? NumberFormatter.formatCurrency(value)
        : '${NumberFormatter.formatResult(value, unit)} $unit';

    final String roundedText = isPriceResult
        ? '' // Currency doesn't need rounded weight helper
        : '≈ ${NumberFormatter.roundedValue(value)} $unit (${LocalizationHelper.translate('rounded', lang)})';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(isDark ? 0.15 : 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          
          // Animate number count changes smoothly
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              final String valStr = isPriceResult 
                  ? NumberFormatter.formatCurrency(animatedValue)
                  : '${NumberFormatter.formatResult(animatedValue, unit)} $unit';
              return Text(
                valStr,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: isPriceResult ? 38 : 42,
                ),
              );
            },
          ),
          
          if (!isPriceResult && roundedText.isNotEmpty && value > 0) ...[
            const SizedBox(height: 4),
            Text(
              roundedText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ],
          
          if (formula.isNotEmpty) ...[
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 12),
            Text(
              LocalizationHelper.translate('formula_breakdown', lang),
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              formula,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.75),
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
