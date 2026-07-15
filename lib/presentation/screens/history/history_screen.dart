// lib/presentation/screens/history/history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/history_model.dart';
import '../../providers/history_provider.dart';
import '../../providers/settings_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';
    final historyAsync = ref.watch(historyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('history', lang)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () => _confirmClearAll(context, lang),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocalizationHelper.translate('search_history', lang),
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() { _searchQuery = ''; });
                          },
                        )
                      : null,
                ),
                onChanged: (val) {
                  setState(() { _searchQuery = val; });
                },
              ),
            ),
            const SizedBox(height: 8),

            // History list
            Expanded(
              child: historyAsync.when(
                data: (allHistory) {
                  var filtered = allHistory.where((h) {
                    if (_searchQuery.isEmpty) return true;
                    return (h.productName ?? '')
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history_rounded, size: 64,
                                color: isDark ? Colors.white24 : Colors.black12),
                            const SizedBox(height: 16),
                            Text(
                              LocalizationHelper.translate('no_history', lang),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Group by date
                  final grouped = _groupByDate(filtered, lang);

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: grouped.length,
                    itemBuilder: (context, index) {
                      final group = grouped[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0 || grouped[index].dateLabel != grouped[index - 1].dateLabel)
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                group.dateLabel,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          Dismissible(
                            key: Key('history_${group.entry.id}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.delete_rounded, color: Colors.red),
                            ),
                            onDismissed: (_) {
                              ref.read(historyListProvider.notifier).deleteEntry(group.entry.id);
                              HapticHelper.heavyImpact();
                            },
                            child: _buildHistoryTile(context, theme, isDark, group.entry, lang),
                          ),
                        ],
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTile(BuildContext context, ThemeData theme, bool isDark, HistoryModel entry, String lang) {
    final isPriceToWeight = entry.calculationType == 'price_to_weight';
    final icon = isPriceToWeight ? Icons.scale_rounded : Icons.currency_rupee_rounded;
    final iconColor = isPriceToWeight ? Colors.blue : Colors.green;

    // Format result summary
    final String summary;
    if (isPriceToWeight) {
      summary = '₹${entry.inputAmount.toStringAsFixed(0)} → ${NumberFormatter.formatResult(entry.resultValue, entry.unit)} ${entry.unit}';
    } else {
      summary = '${entry.inputQuantity.toStringAsFixed(1)} ${entry.unit} → ${NumberFormatter.formatCurrency(entry.resultValue)}';
    }

    // Format timestamp
    final timeStr = _formatTimeAgo(entry.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Re-open calculator with these values
            // For simplicity we just navigate
            if (isPriceToWeight) {
              context.push('/price-to-weight');
            } else {
              context.push('/weight-to-price');
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: iconColor.withOpacity(0.12),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.productName ?? (lang == 'hi' ? 'जल्दी हिसाब' : 'Quick Calc'),
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        summary,
                        style: theme.textTheme.bodyMedium?.copyWith(color: iconColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  timeStr,
                  style: theme.textTheme.labelLarge?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 200.ms);
  }

  List<_GroupedHistoryItem> _groupByDate(List<HistoryModel> items, String lang) {
    final now = DateTime.now();
    return items.map((entry) {
      final diff = now.difference(entry.timestamp);
      String label;
      if (diff.inDays == 0 && now.day == entry.timestamp.day) {
        label = LocalizationHelper.translate('today', lang);
      } else if (diff.inDays <= 1 && now.day - entry.timestamp.day == 1) {
        label = LocalizationHelper.translate('yesterday', lang);
      } else if (diff.inDays <= 7) {
        label = LocalizationHelper.translate('this_week', lang);
      } else {
        label = LocalizationHelper.translate('older', lang);
      }
      return _GroupedHistoryItem(dateLabel: label, entry: entry);
    }).toList();
  }

  String _formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('dd/MM HH:mm').format(timestamp);
  }

  void _confirmClearAll(BuildContext context, String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocalizationHelper.translate('clear_all', lang)),
        content: Text(LocalizationHelper.translate('clear_history_confirm', lang)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocalizationHelper.translate('cancel', lang)),
          ),
          TextButton(
            onPressed: () {
              ref.read(historyListProvider.notifier).clearAll();
              HapticHelper.heavyImpact();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(LocalizationHelper.translate('history_cleared', lang))),
              );
            },
            child: Text(LocalizationHelper.translate('delete', lang),
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _GroupedHistoryItem {
  final String dateLabel;
  final HistoryModel entry;

  _GroupedHistoryItem({required this.dateLabel, required this.entry});
}
