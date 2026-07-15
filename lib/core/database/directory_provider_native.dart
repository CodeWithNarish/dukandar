// lib/core/database/directory_provider_native.dart
// Native platform (Android, iOS, Desktop) implementation

import 'package:path_provider/path_provider.dart';

Future<String> getDirectoryPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}
