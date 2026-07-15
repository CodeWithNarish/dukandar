// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/isar_service.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'presentation/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar Local Database with error handling
  try {
    await IsarService.initialize();
  } catch (e, stack) {
    print('❌ Isar initialization failed: $e');
    print(stack);
    // Run with error state
    runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Database Initialization Failed',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$e',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return;
  }

  runApp(
    const ProviderScope(
      child: DukandarApp(),
    ),
  );
}

class DukandarApp extends ConsumerWidget {
  const DukandarApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsyncValue = ref.watch(settingsNotifierProvider);

    return settingsAsyncValue.when(
      data: (settings) {
        ThemeMode themeMode = ThemeMode.system;
        if (settings.themeMode == 'light') {
          themeMode = ThemeMode.light;
        } else if (settings.themeMode == 'dark') {
          themeMode = ThemeMode.dark;
        }

        return MaterialApp.router(
          title: 'Dukandar',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: appRouter,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization Error: $err'),
          ),
        ),
      ),
    );
  }
}
