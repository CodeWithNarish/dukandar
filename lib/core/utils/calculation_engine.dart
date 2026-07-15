// lib/core/utils/calculation_engine.dart

class CalculationEngine {
  /// Calculate weight from price
  /// Example: Product Price = 80 per 1 KG, Customer budget = ₹35
  /// Returns the amount in the base unit (e.g. 0.4375 KG)
  static double calculatePriceToWeight({
    required double productPrice,      // e.g., 80
    required double baseQuantity,      // e.g., 1
    required double customerAmount,    // e.g., 35
  }) {
    if (productPrice <= 0 || baseQuantity <= 0) return 0;
    final pricePerUnit = productPrice / baseQuantity;
    return customerAmount / pricePerUnit;
  }

  /// Calculate price from weight
  /// Example: Price = 80 per 1 KG, Customer weight = 0.75 KG
  /// Returns the budget amount (e.g. 60 ₹)
  static double calculateWeightToPrice({
    required double productPrice,      // e.g., 80
    required double baseQuantity,      // e.g., 1
    required double customerQuantity,  // e.g., 0.75
  }) {
    if (baseQuantity <= 0) return 0;
    final pricePerUnit = productPrice / baseQuantity;
    return pricePerUnit * customerQuantity;
  }

  /// Profit Calculator
  static ProfitResult calculateProfit({
    required double costPrice,
    required double sellingPrice,
  }) {
    final profit = sellingPrice - costPrice;
    final profitPercent = costPrice > 0 ? (profit / costPrice) * 100 : 0.0;
    final marginPercent = sellingPrice > 0 ? (profit / sellingPrice) * 100 : 0.0;

    return ProfitResult(
      profitAmount: profit,
      profitPercent: profitPercent,
      marginPercent: marginPercent,
      isProfit: profit >= 0,
    );
  }

  /// Discount Calculator
  static DiscountResult calculateDiscount({
    required double originalPrice,
    required double discountPercent,
  }) {
    final discountAmount = originalPrice * (discountPercent / 100);
    final finalPrice = originalPrice - discountAmount;

    return DiscountResult(
      discountAmount: discountAmount,
      finalPrice: finalPrice,
      savings: discountAmount,
    );
  }

  /// GST Calculator (Add Mode)
  static GSTResult calculateGSTAdd({
    required double amount,
    required double gstPercent,
  }) {
    final gstValue = amount * (gstPercent / 100);
    final finalAmount = amount + gstValue;

    return GSTResult(
      gstValue: gstValue,
      finalAmount: finalAmount,
      baseAmount: amount,
    );
  }

  /// GST Calculator (Remove Mode - reverse from inclusive amount)
  static GSTResult calculateGSTRemove({
    required double inclusiveAmount,
    required double gstPercent,
  }) {
    final baseAmount = inclusiveAmount / (1 + gstPercent / 100);
    final gstValue = inclusiveAmount - baseAmount;

    return GSTResult(
      gstValue: gstValue,
      finalAmount: inclusiveAmount,
      baseAmount: baseAmount,
    );
  }

  /// Convert quantity between units of the same category (e.g. KG to Gram, Dozen to Piece)
  static double convertUnit({
    required double value,
    required String fromUnit,
    required String toUnit,
  }) {
    if (fromUnit == toUnit) return value;
    final baseValue = _toBaseUnit(value, fromUnit);
    return _fromBaseUnit(baseValue, toUnit);
  }

  /// Helper to convert a unit value to its base common unit (Grams, ML, Pieces, Feet)
  static double _toBaseUnit(double value, String unit) {
    switch (unit) {
      case 'KG':
        return value * 1000.0; // Base: Grams
      case 'Gram':
        return value;
      case 'Litre':
        return value * 1000.0; // Base: ML
      case 'ML':
        return value;
      case 'Dozen':
        return value * 12.0; // Base: Pieces
      case 'Piece':
        return value;
      case 'Meter':
        return value * 3.28084; // Base: Feet (or convert both to inches/feet)
      case 'Feet':
        return value;
      default:
        return value; // For Packet, Bottle, Bag
    }
  }

  /// Helper to convert from the base unit back to the target unit
  static double _fromBaseUnit(double baseValue, String unit) {
    switch (unit) {
      case 'KG':
        return baseValue / 1000.0;
      case 'Gram':
        return baseValue;
      case 'Litre':
        return baseValue / 1000.0;
      case 'ML':
        return baseValue;
      case 'Dozen':
        return baseValue / 12.0;
      case 'Piece':
        return baseValue;
      case 'Meter':
        return baseValue / 3.28084;
      case 'Feet':
        return baseValue;
      default:
        return baseValue;
    }
  }

  /// Check if two units are in the same conversion group
  static bool areUnitsCompatible(String unit1, String unit2) {
    final group1 = _getUnitGroup(unit1);
    final group2 = _getUnitGroup(unit2);
    return group1 == group2;
  }

  static String _getUnitGroup(String unit) {
    if (unit == 'KG' || unit == 'Gram') return 'weight';
    if (unit == 'Litre' || unit == 'ML') return 'volume';
    if (unit == 'Dozen' || unit == 'Piece') return 'count';
    if (unit == 'Meter' || unit == 'Feet') return 'length';
    return unit; // Packet, Bottle, Bag remain in their own individual categories
  }
}

class ProfitResult {
  final double profitAmount;
  final double profitPercent;
  final double marginPercent;
  final bool isProfit;

  ProfitResult({
    required this.profitAmount,
    required this.profitPercent,
    required this.marginPercent,
    required this.isProfit,
  });
}

class DiscountResult {
  final double discountAmount;
  final double finalPrice;
  final double savings;

  DiscountResult({
    required this.discountAmount,
    required this.finalPrice,
    required this.savings,
  });
}

class GSTResult {
  final double gstValue;
  final double finalAmount;
  final double baseAmount;

  GSTResult({
    required this.gstValue,
    required this.finalAmount,
    required this.baseAmount,
  });
}
