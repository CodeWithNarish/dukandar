// lib/data/models/history_model.dart

import 'package:isar/isar.dart';

part 'history_model.g.dart';

@collection
class HistoryModel {
  Id id = Isar.autoIncrement;

  String? productName;

  late String calculationType; // 'price_to_weight' | 'weight_to_price'

  late double inputPrice;
  
  late double inputQuantity; // baseQuantity for price_to_weight, customerQuantity for weight_to_price
  
  late String unit;

  late double inputAmount; // customerAmount for price_to_weight, 0 for weight_to_price (or actual paid)
  
  late double resultValue; // result in weight/units for price_to_weight, result in ₹ for weight_to_price

  @Index()
  late DateTime timestamp;

  int? linkedProductId;
}
