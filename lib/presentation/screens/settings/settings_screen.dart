// lib/presentation/screens/settings/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../app/theme/app_colors.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';
    final currentTheme = settingsAsync.value?.themeMode ?? 'system';
    final autoSave = settingsAsync.value?.autoSaveHistory ?? true;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('settings', lang)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── APPEARANCE ───────────────────────────────────
              _SectionHeader(title: LocalizationHelper.translate('appearance', lang)),
              const SizedBox(height: 8),
              PremiumCard(
                glassmorphic: true,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.light_mode_rounded,
                      iconColor: Colors.orange,
                      title: LocalizationHelper.translate('theme_mode', lang),
                      trailing: _ThemeSelector(
                        currentTheme: currentTheme,
                        lang: lang,
                        onChanged: (mode) {
                          ref.read(settingsNotifierProvider.notifier).updateThemeMode(mode);
                          HapticHelper.selectionClick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ─── LANGUAGE ─────────────────────────────────────
              _SectionHeader(title: LocalizationHelper.translate('language', lang)),
              const SizedBox(height: 8),
              PremiumCard(
                glassmorphic: true,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.translate_rounded,
                      iconColor: Colors.blue,
                      title: LocalizationHelper.translate('language', lang),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _LangChip(
                              label: 'English',
                              isSelected: lang == 'en',
                              onTap: () {
                                ref.read(settingsNotifierProvider.notifier).updateLanguage('en');
                                HapticHelper.selectionClick();
                              },
                            ),
                            const SizedBox(width: 4),
                            _LangChip(
                              label: 'हिंदी',
                              isSelected: lang == 'hi',
                              onTap: () {
                                ref.read(settingsNotifierProvider.notifier).updateLanguage('hi');
                                HapticHelper.selectionClick();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ─── HISTORY ──────────────────────────────────────
              _SectionHeader(title: LocalizationHelper.translate('history_settings', lang)),
              const SizedBox(height: 8),
              PremiumCard(
                glassmorphic: true,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.save_rounded,
                      iconColor: Colors.green,
                      title: LocalizationHelper.translate('auto_save', lang),
                      trailing: Switch.adaptive(
                        value: autoSave,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (val) {
                          ref.read(settingsNotifierProvider.notifier).updateAutoSaveHistory(val);
                          HapticHelper.selectionClick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ─── ABOUT ────────────────────────────────────────
              _SectionHeader(title: LocalizationHelper.translate('about', lang)),
              const SizedBox(height: 8),
              PremiumCard(
                glassmorphic: true,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: Colors.grey,
                      title: LocalizationHelper.translate('app_version', lang),
                      trailing: Text('1.0.0', style: theme.textTheme.bodyMedium),
                    ),
                    Divider(color: isDark ? AppColors.darkDivider : AppColors.lightDivider),
                    _SettingsTile(
                      icon: Icons.restore_rounded,
                      iconColor: Colors.red,
                      title: LocalizationHelper.translate('reset_app', lang),
                      onTap: () => _confirmReset(context, ref, lang),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref, String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocalizationHelper.translate('reset_app', lang)),
        content: Text(LocalizationHelper.translate('reset_confirm', lang)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocalizationHelper.translate('cancel', lang)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(settingsNotifierProvider.notifier).resetApplication();
              HapticHelper.heavyImpact();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocalizationHelper.translate('app_reset_success', lang))),
                );
              }
            },
            child: Text(LocalizationHelper.translate('delete', lang),
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ─── Helper Widgets ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor.withOpacity(0.12),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  final String currentTheme;
  final String lang;
  final ValueChanged<String> onChanged;

  const _ThemeSelector({
    required this.currentTheme,
    required this.lang,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemeChip(
            icon: Icons.light_mode_rounded,
            isSelected: currentTheme == 'light',
            onTap: () => onChanged('light'),
          ),
          const SizedBox(width: 2),
          _ThemeChip(
            icon: Icons.dark_mode_rounded,
            isSelected: currentTheme == 'dark',
            onTap: () => onChanged('dark'),
          ),
          const SizedBox(width: 2),
          _ThemeChip(
            icon: Icons.settings_suggest_rounded,
            isSelected: currentTheme == 'system',
            onTap: () => onChanged('system'),
          ),
        ],
      ),
    );
  }
}

class _ThemeChip extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeChip({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : (theme.brightness == Brightness.dark ? Colors.white38 : Colors.black38),
        ),
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : (theme.brightness == Brightness.dark ? Colors.white38 : Colors.black38),
          ),
        ),
      ),
    );
  }
}
