// lib/presentation/widgets/common/premium_text_field.dart

import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class PremiumTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final String? prefix;
  final String? suffix;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;

  const PremiumTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.prefix,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.controller,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<PremiumTextField> createState() => _PremiumTextFieldState();
}

class _PremiumTextFieldState extends State<PremiumTextField> {
  late TextEditingController _effectiveController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController(text: widget.initialValue);
    
    // Select all text on focus for easier shopkeeper updates
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _effectiveController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _effectiveController.text.length,
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant PremiumTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.initialValue != null && widget.initialValue != _effectiveController.text) {
      // Safely update the value without resetting cursor unless necessary
      final currentSelection = _effectiveController.selection;
      _effectiveController.text = widget.initialValue!;
      // Keep selection if it was focused
      if (_focusNode.hasFocus) {
        _effectiveController.selection = currentSelection;
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget? prefixWidget;
    if (widget.prefix != null) {
      prefixWidget = Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 4.0),
        child: Text(
          widget.prefix!,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
      );
    }

    Widget? suffixWidget;
    if (widget.suffix != null) {
      suffixWidget = Text(
        widget.suffix!,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
            child: Text(
              widget.label!,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ),
        ],
        TextField(
          controller: _effectiveController,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: prefixWidget,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffixWidget,
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          ),
        ),
      ],
    );
  }
}
