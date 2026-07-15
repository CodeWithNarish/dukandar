// lib/core/database/web_db_stub.dart

class WebDbMock {
  dynamic get productModels => null;
  dynamic get historyModels => null;
  dynamic get shopProfileModels => null;
  dynamic get settingsModels => null;

  Future<void> initialize() async {}

  Future<T> writeTxn<T>(Future<T> Function() callback) async {
    return await callback();
  }
}
