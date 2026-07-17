# Isar Database - prevent ProGuard from stripping native bindings
-keep class dev.isar.isar_flutter_libs.** { *; }
-keep class io.isar.** { *; }
-dontwarn io.isar.**
