// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_profile_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShopProfileModelCollection on Isar {
  IsarCollection<ShopProfileModel> get shopProfileModels => this.collection();
}

const ShopProfileModelSchema = CollectionSchema(
  name: r'ShopProfileModel',
  id: 4881038503994177536,
  properties: {
    r'defaultCurrency': PropertySchema(
      id: 0,
      name: r'defaultCurrency',
      type: IsarType.string,
    ),
    r'defaultWeightUnit': PropertySchema(
      id: 1,
      name: r'defaultWeightUnit',
      type: IsarType.string,
    ),
    r'logoPath': PropertySchema(
      id: 2,
      name: r'logoPath',
      type: IsarType.string,
    ),
    r'ownerName': PropertySchema(
      id: 3,
      name: r'ownerName',
      type: IsarType.string,
    ),
    r'shopName': PropertySchema(
      id: 4,
      name: r'shopName',
      type: IsarType.string,
    )
  },
  estimateSize: _shopProfileModelEstimateSize,
  serialize: _shopProfileModelSerialize,
  deserialize: _shopProfileModelDeserialize,
  deserializeProp: _shopProfileModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _shopProfileModelGetId,
  getLinks: _shopProfileModelGetLinks,
  attach: _shopProfileModelAttach,
  version: '3.1.0+1',
);

int _shopProfileModelEstimateSize(
  ShopProfileModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.defaultCurrency.length * 3;
  bytesCount += 3 + object.defaultWeightUnit.length * 3;
  {
    final value = object.logoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ownerName.length * 3;
  bytesCount += 3 + object.shopName.length * 3;
  return bytesCount;
}

void _shopProfileModelSerialize(
  ShopProfileModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.defaultCurrency);
  writer.writeString(offsets[1], object.defaultWeightUnit);
  writer.writeString(offsets[2], object.logoPath);
  writer.writeString(offsets[3], object.ownerName);
  writer.writeString(offsets[4], object.shopName);
}

ShopProfileModel _shopProfileModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShopProfileModel();
  object.defaultCurrency = reader.readString(offsets[0]);
  object.defaultWeightUnit = reader.readString(offsets[1]);
  object.id = id;
  object.logoPath = reader.readStringOrNull(offsets[2]);
  object.ownerName = reader.readString(offsets[3]);
  object.shopName = reader.readString(offsets[4]);
  return object;
}

P _shopProfileModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shopProfileModelGetId(ShopProfileModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shopProfileModelGetLinks(ShopProfileModel object) {
  return [];
}

void _shopProfileModelAttach(
    IsarCollection<dynamic> col, Id id, ShopProfileModel object) {
  object.id = id;
}

extension ShopProfileModelQueryWhereSort
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QWhere> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShopProfileModelQueryWhere
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QWhereClause> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShopProfileModelQueryFilter
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QFilterCondition> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultWeightUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultWeightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultWeightUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultWeightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      defaultWeightUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultWeightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logoPath',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logoPath',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      logoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      ownerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shopName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shopName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shopName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shopName',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterFilterCondition>
      shopNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shopName',
        value: '',
      ));
    });
  }
}

extension ShopProfileModelQueryObject
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QFilterCondition> {}

extension ShopProfileModelQueryLinks
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QFilterCondition> {}

extension ShopProfileModelQuerySortBy
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QSortBy> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByDefaultCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrency', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByDefaultCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrency', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByDefaultWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultWeightUnit', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByDefaultWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultWeightUnit', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByLogoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoPath', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByLogoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoPath', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByOwnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerName', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByOwnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerName', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByShopName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shopName', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      sortByShopNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shopName', Sort.desc);
    });
  }
}

extension ShopProfileModelQuerySortThenBy
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QSortThenBy> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByDefaultCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrency', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByDefaultCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrency', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByDefaultWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultWeightUnit', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByDefaultWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultWeightUnit', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByLogoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoPath', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByLogoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoPath', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByOwnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerName', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByOwnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerName', Sort.desc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByShopName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shopName', Sort.asc);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QAfterSortBy>
      thenByShopNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shopName', Sort.desc);
    });
  }
}

extension ShopProfileModelQueryWhereDistinct
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct> {
  QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct>
      distinctByDefaultCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultCurrency',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct>
      distinctByDefaultWeightUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultWeightUnit',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct>
      distinctByLogoPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct>
      distinctByOwnerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopProfileModel, ShopProfileModel, QDistinct>
      distinctByShopName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shopName', caseSensitive: caseSensitive);
    });
  }
}

extension ShopProfileModelQueryProperty
    on QueryBuilder<ShopProfileModel, ShopProfileModel, QQueryProperty> {
  QueryBuilder<ShopProfileModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShopProfileModel, String, QQueryOperations>
      defaultCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultCurrency');
    });
  }

  QueryBuilder<ShopProfileModel, String, QQueryOperations>
      defaultWeightUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultWeightUnit');
    });
  }

  QueryBuilder<ShopProfileModel, String?, QQueryOperations> logoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoPath');
    });
  }

  QueryBuilder<ShopProfileModel, String, QQueryOperations> ownerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerName');
    });
  }

  QueryBuilder<ShopProfileModel, String, QQueryOperations> shopNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shopName');
    });
  }
}
