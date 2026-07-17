// lib/core/database/land_db_storage.dart
// Conditional import: uses web impl on web, stub on native

export 'land_db_storage_web.dart'
    if (dart.library.io) 'land_db_storage_native.dart';
