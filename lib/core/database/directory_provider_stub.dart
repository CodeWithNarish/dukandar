// lib/core/database/directory_provider_stub.dart
// Stub for web platform

Future<String> getDirectoryPath() async {
  throw UnsupportedError('Cannot get directory path on Web');
}

Future<void> recoverDatabase() async {
  // Web does not need file-based database recovery
}
