// lib/core/database/land_db_storage_web.dart
// Web implementation using dart:html localStorage

import 'dart:html' as html;

class LandStorage {
  static String? read(String key) {
    return html.window.localStorage[key];
  }

  static void write(String key, String value) {
    html.window.localStorage[key] = value;
  }
}
