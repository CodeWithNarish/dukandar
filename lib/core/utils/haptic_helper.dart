// lib/core/utils/haptic_helper.dart

import 'package:flutter/services.dart';

class HapticHelper {
  /// Soft/light tap haptic feedback (button presses)
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium tap feedback (save success, page toggle)
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact feedback (deletes, clears, resets, errors)
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// Delicate click feedback (unit selector scrolling, dial changes)
  static Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }

  /// Standard keyboard tap feedback
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }
}
