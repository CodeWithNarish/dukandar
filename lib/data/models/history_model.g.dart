// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHistoryModelCollection on Isar {
  IsarCollection<HistoryModel> get historyModels => this.collection();
}

const HistoryModelSchema = CollectionSchema(
  name: r'HistoryModel',
  id: 5151902556644193280,
  properties: {
    r'calculationType': PropertySchema(
      id: 0,
      name: r'calculationType',
      type: IsarType.string,
    ),
    r'inputAmount': PropertySchema(
      id: 1,
      name: r'inputAmount',
      type: IsarType.double,
    ),
    r'inputPrice': PropertySchema(
      id: 2,
      name: r'inputPrice',
      type: IsarType.double,
    ),
    r'inputQuantity': PropertySchema(
      id: 3,
      name: r'inputQuantity',
      type: IsarType.double,
    ),
    r'linkedProductId': PropertySchema(
      id: 4,
      name: r'linkedProductId',
      type: IsarType.long,
    ),
    r'productName': PropertySchema(
      id: 5,
      name: r'productName',
      type: IsarType.string,
    ),
    r'resultValue': PropertySchema(
      id: 6,
      name: r'resultValue',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 7,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'unit': PropertySchema(
      id: 8,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _historyModelEstimateSize,
  serialize: _historyModelSerialize,
  deserialize: _historyModelDeserialize,
  deserializeProp: _historyModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'timestamp': IndexSchema(
      id: 1852253767416892160,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _historyModelGetId,
  getLinks: _historyModelGetLinks,
  attach: _historyModelAttach,
  version: '3.1.0+1',
);

int _historyModelEstimateSize(
  HistoryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.calculationType.length * 3;
  {
    final value = object.productName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _historyModelSerialize(
  HistoryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.calculationType);
  writer.writeDouble(offsets[1], object.inputAmount);
  writer.writeDouble(offsets[2], object.inputPrice);
  writer.writeDouble(offsets[3], object.inputQuantity);
  writer.writeLong(offsets[4], object.linkedProductId);
  writer.writeString(offsets[5], object.productName);
  writer.writeDouble(offsets[6], object.resultValue);
  writer.writeDateTime(offsets[7], object.timestamp);
  writer.writeString(offsets[8], object.unit);
}

HistoryModel _historyModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HistoryModel();
  object.calculationType = reader.readString(offsets[0]);
  object.id = id;
  object.inputAmount = reader.readDouble(offsets[1]);
  object.inputPrice = reader.readDouble(offsets[2]);
  object.inputQuantity = reader.readDouble(offsets[3]);
  object.linkedProductId = reader.readLongOrNull(offsets[4]);
  object.productName = reader.readStringOrNull(offsets[5]);
  object.resultValue = reader.readDouble(offsets[6]);
  object.timestamp = reader.readDateTime(offsets[7]);
  object.unit = reader.readString(offsets[8]);
  return object;
}

P _historyModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _historyModelGetId(HistoryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _historyModelGetLinks(HistoryModel object) {
  return [];
}

void _historyModelAttach(
    IsarCollection<dynamic> col, Id id, HistoryModel object) {
  object.id = id;
}

extension HistoryModelQueryWhereSort
    on QueryBuilder<HistoryModel, HistoryModel, QWhere> {
  QueryBuilder<HistoryModel, HistoryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension HistoryModelQueryWhere
    on QueryBuilder<HistoryModel, HistoryModel, QWhereClause> {
  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> timestampEqualTo(
      DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause>
      timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause>
      timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterWhereClause> timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HistoryModelQueryFilter
    on QueryBuilder<HistoryModel, HistoryModel, QFilterCondition> {
  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calculationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'calculationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'calculationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calculationType',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      calculationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'calculationType',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputQuantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      inputQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputQuantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedProductId',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedProductId',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedProductId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedProductId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedProductId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      linkedProductIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedProductId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      resultValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resultValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      resultValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resultValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      resultValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resultValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      resultValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resultValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension HistoryModelQueryObject
    on QueryBuilder<HistoryModel, HistoryModel, QFilterCondition> {}

extension HistoryModelQueryLinks
    on QueryBuilder<HistoryModel, HistoryModel, QFilterCondition> {}

extension HistoryModelQuerySortBy
    on QueryBuilder<HistoryModel, HistoryModel, QSortBy> {
  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByCalculationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculationType', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByCalculationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculationType', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByInputAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputAmount', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByInputAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputAmount', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByInputPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputPrice', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByInputPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputPrice', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByInputQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputQuantity', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByInputQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputQuantity', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByLinkedProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedProductId', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByLinkedProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedProductId', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByResultValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultValue', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      sortByResultValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultValue', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension HistoryModelQuerySortThenBy
    on QueryBuilder<HistoryModel, HistoryModel, QSortThenBy> {
  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByCalculationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculationType', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByCalculationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculationType', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByInputAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputAmount', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByInputAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputAmount', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByInputPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputPrice', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByInputPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputPrice', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByInputQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputQuantity', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByInputQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inputQuantity', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByLinkedProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedProductId', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByLinkedProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedProductId', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByResultValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultValue', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy>
      thenByResultValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultValue', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension HistoryModelQueryWhereDistinct
    on QueryBuilder<HistoryModel, HistoryModel, QDistinct> {
  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByCalculationType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calculationType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByInputAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inputAmount');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByInputPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inputPrice');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct>
      distinctByInputQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inputQuantity');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct>
      distinctByLinkedProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedProductId');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByProductName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByResultValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resultValue');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<HistoryModel, HistoryModel, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension HistoryModelQueryProperty
    on QueryBuilder<HistoryModel, HistoryModel, QQueryProperty> {
  QueryBuilder<HistoryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HistoryModel, String, QQueryOperations>
      calculationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calculationType');
    });
  }

  QueryBuilder<HistoryModel, double, QQueryOperations> inputAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputAmount');
    });
  }

  QueryBuilder<HistoryModel, double, QQueryOperations> inputPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputPrice');
    });
  }

  QueryBuilder<HistoryModel, double, QQueryOperations> inputQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputQuantity');
    });
  }

  QueryBuilder<HistoryModel, int?, QQueryOperations> linkedProductIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedProductId');
    });
  }

  QueryBuilder<HistoryModel, String?, QQueryOperations> productNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productName');
    });
  }

  QueryBuilder<HistoryModel, double, QQueryOperations> resultValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resultValue');
    });
  }

  QueryBuilder<HistoryModel, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<HistoryModel, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
