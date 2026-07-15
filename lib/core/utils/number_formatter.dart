// lib/core/utils/number_formatter.dart

import 'package:intl/intl.dart';

class NumberFormatter {
  /// Smart formatting for weights and quantities
  static String formatResult(double value, String unit) {
    if (value.isNaN || value.isInfinite) return '0';
    
    // For weight/volume smaller units, display 1 decimal place or whole number
    if (unit == 'Gram' || unit == 'ML') {
      if (value == value.roundToDouble()) {
        return value.toStringAsFixed(0);
      }
      return value.toStringAsFixed(1);
    } 
    // For KG / Litre, show up to 3 decimal places
    else if (unit == 'KG' || unit == 'Litre') {
      if (value == value.roundToDouble()) {
        return value.toStringAsFixed(0);
      }
      // Remove trailing zeroes if unnecessary
      final formatted = value.toStringAsFixed(3);
      if (formatted.endsWith('.000')) {
        return value.toStringAsFixed(0);
      }
      return formatted;
    } 
    // For meters, feet, etc. show up to 2 decimal places
    else {
      if (value == value.roundToDouble()) {
        return value.toStringAsFixed(0);
      }
      return value.toStringAsFixed(2);
    }
  }

  /// Round value to the nearest integer
  static int roundedValue(double value) {
    if (value.isNaN || value.isInfinite) return 0;
    return value.round();
  }

  /// Currency formatting: e.g. ₹35.00, ₹1,25,000.00 (Indian Number Format)
  static String formatCurrency(double value) {
    if (value.isNaN || value.isInfinite) return '₹0.00';
    
    try {
      // standard Indian currency format (e.g. 12,34,567.89)
      final formatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: value == value.roundToDouble() ? 0 : 2,
      );
      return formatter.format(value);
    } catch (e) {
      // Fallback in case of locale issues
      if (value == value.roundToDouble()) {
        return '₹${value.toStringAsFixed(0)}';
      }
      return '₹${value.toStringAsFixed(2)}';
    }
  }

  /// Simplistic double parsing that handles empty strings or trailing dots gracefully
  static double parseDouble(String val) {
    if (val.isEmpty) return 0.0;
    // Strip out currency symbols or commas if entered
    final cleanVal = val.replaceAll('₹', '').replaceAll(',', '').trim();
    return double.tryParse(cleanVal) ?? 0.0;
  }
}
