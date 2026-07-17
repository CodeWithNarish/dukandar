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
    final dirPath = await getDirectoryPath();
    
    Future<void> safeDelete(String path) async {
      final file = File(path);
      final dir = Directory(path);
      
      if (await file.exists()) {
        try {
          await file.delete();
          print('🗑️ Deleted file: $path');
        } catch (e) {
          print('⚠️ Delete file failed, trying rename fallback: $e');
          try {
            final newPath = '$path.bak_${DateTime.now().millisecondsSinceEpoch}';
            await file.rename(newPath);
            print('🔄 Renamed file to: $newPath');
          } catch (renameError) {
            print('❌ Rename file failed: $renameError');
          }
        }
      } else if (await dir.exists()) {
        try {
          await dir.delete(recursive: true);
          print('🗑️ Deleted directory: $path');
        } catch (e) {
          print('⚠️ Delete directory failed, trying rename fallback: $e');
          try {
            final newPath = '$path.bak_${DateTime.now().millisecondsSinceEpoch}';
            await dir.rename(newPath);
            print('🔄 Renamed directory to: $newPath');
          } catch (renameError) {
            print('❌ Rename directory failed: $renameError');
          }
        }
      }
    }

    await safeDelete('$dirPath/dukandar_db.isar');
    await safeDelete('$dirPath/dukandar_db.isar.lock');
  } catch (e) {
    print('❌ Native Recovery failed: $e');
  }
}
