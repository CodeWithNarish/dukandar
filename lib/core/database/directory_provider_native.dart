// lib/core/database/directory_provider_native.dart
// Native platform (Android, iOS, Desktop) implementation

import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getDirectoryPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<void> recoverDatabase() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final dbFile = File('${dir.path}/dukandar_db.isar');
    final lockFile = File('${dir.path}/dukandar_db.isar.lock');
    
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('🗑️ Deleted corrupted database file');
    }
    
    if (await lockFile.exists()) {
      await lockFile.delete();
    }
  } catch (e) {
    print('❌ Native Recovery failed: $e');
  }
}
