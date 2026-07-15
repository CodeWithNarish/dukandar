// test/calculation_engine_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:dukandar/core/utils/calculation_engine.dart';

void main() {
  group('CalculationEngine Unit Tests', () {
    test('Price to Weight - budget weight output', () {
      final result = CalculationEngine.calculatePriceToWeight(
        productPrice: 80,
        baseQuantity: 1,
        customerAmount: 35,
      );
      // 35 / (80 / 1) = 0.4375 KG
      expect(result, 0.4375);
    });

    test('Weight to Price - exact cost output', () {
      final result = CalculationEngine.calculateWeightToPrice(
        productPrice: 80,
        baseQuantity: 1,
        customerQuantity: 0.75,
      );
      // (80 / 1) * 0.75 = 60 ₹
      expect(result, 60.0);
    });

    test('Profit/Loss - positive profit, markup and margin', () {
      final result = CalculationEngine.calculateProfit(
        costPrice: 100,
        sellingPrice: 125,
      );
      expect(result.profitAmount, 25.0);
      expect(result.profitPercent, 25.0);
      expect(result.marginPercent, 20.0);
      expect(result.isProfit, true);
    });

    test('Discount - savings deduction', () {
      final result = CalculationEngine.calculateDiscount(
        originalPrice: 200,
        discountPercent: 15,
      );
      expect(result.discountAmount, 30.0);
      expect(result.finalPrice, 170.0);
      expect(result.savings, 30.0);
    });

    test('GST Add - value addition', () {
      final result = CalculationEngine.calculateGSTAdd(
        amount: 100,
        gstPercent: 18,
      );
      expect(result.gstValue, 18.0);
      expect(result.finalAmount, 118.0);
      expect(result.baseAmount, 100.0);
    });

    test('GST Remove - reverse calculation', () {
      final result = CalculationEngine.calculateGSTRemove(
        inclusiveAmount: 118,
        gstPercent: 18,
      );
      expect(result.baseAmount, 100.0);
      expect(result.gstValue, 18.0);
      expect(result.finalAmount, 118.0);
    });

    test('Unit conversion - KG to Gram', () {
      final result = CalculationEngine.convertUnit(
        value: 1.5,
        fromUnit: 'KG',
        toUnit: 'Gram',
      );
      expect(result, 1500.0);
    });

    test('Unit conversion - Litre to ML', () {
      final result = CalculationEngine.convertUnit(
        value: 0.75,
        fromUnit: 'Litre',
        toUnit: 'ML',
      );
      expect(result, 750.0);
    });
  });
}
