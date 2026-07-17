// lib/core/database/land_db_storage_native.dart
// Native in-memory storage (Android, iOS, Windows, macOS, Linux)
// For a production app this would use SharedPreferences or a local file.

class LandStorage {
  static final Map<String, String> _store = {};

  static String? read(String key) {
    return _store[key];
  }

  static void write(String key, String value) {
    _store[key] = value;
  }
}
