// lib/data/models/land_field_model.dart

class LandFieldModel {
  int id;
  String fieldName;
  double length1;
  double length2;
  double width1;
  double width2;
  String measurementUnit; // 'feet', 'meter', 'yard'
  String localUnit;       // 'bigha', 'acre', 'hectare', 'sqft', 'sqmeter', 'sqyard'
  double conversionValue; // e.g. 1 bigha = 27225 sqft or 843 sq meter
  double areaSqFt;
  double localUnitArea;
  bool isFavorite;
  String notes;
  DateTime createdAt;

  LandFieldModel({
    this.id = 0,
    this.fieldName = '',
    this.length1 = 0,
    this.length2 = 0,
    this.width1 = 0,
    this.width2 = 0,
    this.measurementUnit = 'feet',
    this.localUnit = 'bigha',
    this.conversionValue = 27225,
    this.areaSqFt = 0,
    this.localUnitArea = 0,
    this.isFavorite = false,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
