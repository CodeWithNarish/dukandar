// lib/presentation/providers/history_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../core/database/isar_service.dart';
import '../../data/models/history_model.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryModel>> build() async {
    return _fetchAll();
  }

  Future<List<HistoryModel>> _fetchAll() async {
    final List<HistoryModel> results = List<HistoryModel>.from(
      await IsarService.isar.historyModels.where().findAll()
    );
    // Sort in Dart with explicit types
    results.sort((HistoryModel a, HistoryModel b) => b.timestamp.compareTo(a.timestamp));
    return results;
  }

  Future<void> addHistoryEntry(HistoryModel entry) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.put(entry);
    });
    ref.invalidateSelf();
  }

  Future<void> deleteEntry(int id) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.delete(id);
    });
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.clear();
    });
    ref.invalidateSelf();
  }

  Future<List<HistoryModel>> searchHistory(String query) async {
    if (query.isEmpty) {
      return _fetchAll();
    }
    final List<HistoryModel> results = List<HistoryModel>.from(
      await IsarService.isar.historyModels.where().findAll()
    );

    final filtered = results.where((h) {
      final q = query.toLowerCase();
      return (h.productName?.toLowerCase().contains(q) ?? false) ||
          h.calculationType.toLowerCase().contains(q);
    }).toList();

    filtered.sort((HistoryModel a, HistoryModel b) => b.timestamp.compareTo(a.timestamp));
    return filtered;
  }
}
