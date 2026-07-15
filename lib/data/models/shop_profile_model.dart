// lib/data/models/shop_profile_model.dart

import 'package:isar/isar.dart';

part 'shop_profile_model.g.dart';

@collection
class ShopProfileModel {
  Id id = Isar.autoIncrement;

  String shopName = '';
  
  String ownerName = '';
  
  String defaultCurrency = '₹';
  
  String defaultWeightUnit = 'KG';
  
  String? logoPath; // In V1, this will store selected avatar identifier/index
}
