// lib/core/database/directory_provider_stub.dart
// Stub for web platform

Future<String> getDirectoryPath() async {
  // On web, Isar uses IndexedDB — no filesystem directory needed
  return '';
}
