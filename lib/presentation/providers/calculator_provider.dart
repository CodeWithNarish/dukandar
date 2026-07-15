// lib/presentation/providers/calculator_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/utils/calculation_engine.dart';
import '../../data/models/product_model.dart';

part 'calculator_provider.g.dart';

class PriceToWeightState {
  final String productName;
  final double price;
  final String unit;
  final double baseQuantity;
  final double customerAmount;
  final double result;

  PriceToWeightState({
    this.productName = '',
    this.price = 0,
    this.unit = 'KG',
    this.baseQuantity = 1,
    this.customerAmount = 0,
    this.result = 0,
  });

  PriceToWeightState copyWith({
    String? productName,
    double? price,
    String? unit,
    double? baseQuantity,
    double? customerAmount,
    double? result,
  }) {
    return PriceToWeightState(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      customerAmount: customerAmount ?? this.customerAmount,
      result: result ?? this.result,
    );
  }
}

class WeightToPriceState {
  final String productName;
  final double price;
  final String unit;
  final double baseQuantity;
  final double customerQuantity;
  final double result;

  WeightToPriceState({
    this.productName = '',
    this.price = 0,
    this.unit = 'KG',
    this.baseQuantity = 1,
    this.customerQuantity = 0,
    this.result = 0,
  });

  WeightToPriceState copyWith({
    String? productName,
    double? price,
    String? unit,
    double? baseQuantity,
    double? customerQuantity,
    double? result,
  }) {
    return WeightToPriceState(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      customerQuantity: customerQuantity ?? this.customerQuantity,
      result: result ?? this.result,
    );
  }
}

@riverpod
class PriceToWeightCalculator extends _$PriceToWeightCalculator {
  @override
  PriceToWeightState build() {
    return PriceToWeightState();
  }

  void updatePrice(double price) {
    state = state.copyWith(price: price);
    _recalculate();
  }

  void updateUnit(String unit) {
    state = state.copyWith(unit: unit);
    _recalculate();
  }

  void updateBaseQuantity(double qty) {
    state = state.copyWith(baseQuantity: qty);
    _recalculate();
  }

  void updateCustomerAmount(double amount) {
    state = state.copyWith(customerAmount: amount);
    _recalculate();
  }

  void updateProductName(String name) {
    state = state.copyWith(productName: name);
  }

  void prefillFromProduct(ProductModel product) {
    state = PriceToWeightState(
      productName: product.name,
      price: product.price,
      unit: product.unit,
      baseQuantity: product.baseQuantity,
      customerAmount: 0.0,
      result: 0.0,
    );
  }

  void _recalculate() {
    final res = CalculationEngine.calculatePriceToWeight(
      productPrice: state.price,
      baseQuantity: state.baseQuantity,
      customerAmount: state.customerAmount,
    );
    state = state.copyWith(result: res);
  }

  void reset() {
    state = PriceToWeightState();
  }
}

@riverpod
class WeightToPriceCalculator extends _$WeightToPriceCalculator {
  @override
  WeightToPriceState build() {
    return WeightToPriceState();
  }

  void updatePrice(double price) {
    state = state.copyWith(price: price);
    _recalculate();
  }

  void updateUnit(String unit) {
    state = state.copyWith(unit: unit);
    _recalculate();
  }

  void updateBaseQuantity(double qty) {
    state = state.copyWith(baseQuantity: qty);
    _recalculate();
  }

  void updateCustomerQuantity(double qty) {
    state = state.copyWith(customerQuantity: qty);
    _recalculate();
  }

  void updateProductName(String name) {
    state = state.copyWith(productName: name);
  }

  void prefillFromProduct(ProductModel product) {
    state = WeightToPriceState(
      productName: product.name,
      price: product.price,
      unit: product.unit,
      baseQuantity: product.baseQuantity,
      customerQuantity: 0.0,
      result: 0.0,
    );
  }

  void _recalculate() {
    final res = CalculationEngine.calculateWeightToPrice(
      productPrice: state.price,
      baseQuantity: state.baseQuantity,
      customerQuantity: state.customerQuantity,
    );
    state = state.copyWith(result: res);
  }

  void reset() {
    state = WeightToPriceState();
  }
}
