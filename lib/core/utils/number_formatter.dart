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

  /// Generic area/quantity formatting: up to 4 decimal places, removes trailing zeros.
  /// E.g. 45000.0 → "45,000"  |  1.6534 → "1.6534"  |  1.50 → "1.5"
  static String format(double value) {
    if (value.isNaN || value.isInfinite) return '0';
    if (value == 0) return '0';
    // Check if it's a whole number
    if (value == value.truncateToDouble()) {
      try {
        final formatter = NumberFormat('#,##,###', 'en_IN');
        return formatter.format(value.toInt());
      } catch (_) {
        return value.toInt().toString();
      }
    }
    // Has decimals — up to 4 places, trim trailing zeros
    String s = value.toStringAsFixed(4);
    s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    // Add comma grouping for the integer part
    final parts = s.split('.');
    try {
      final formatter = NumberFormat('#,##,###', 'en_IN');
      final intPart = formatter.format(int.tryParse(parts[0]) ?? 0);
      return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
    } catch (_) {
      return s;
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
