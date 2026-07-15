// lib/presentation/widgets/common/premium_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';

class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool glassmorphic;
  final List<BoxShadow>? customShadows;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(16.0),
    this.glassmorphic = true,
    this.customShadows,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
      HapticHelper.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap!();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Choose appropriate background color
    final defaultBgColor = isDark 
        ? (widget.glassmorphic ? AppColors.darkCardGlass : AppColors.darkCardBg)
        : (widget.glassmorphic ? AppColors.lightCardGlass : AppColors.lightCardBg);
        
    final cardColor = widget.color ?? defaultBgColor;

    // Border definition
    final cardBorder = Border.all(
      color: isDark 
          ? Colors.white.withOpacity(0.08) 
          : Colors.black.withOpacity(0.05),
      width: 1.0,
    );

    // Shadow definition
    final defaultShadows = [
      BoxShadow(
        color: isDark 
            ? Colors.black.withOpacity(0.3) 
            : Colors.black.withOpacity(0.04),
        blurRadius: 16.0,
        offset: const Offset(0, 4),
      )
    ];
    final cardShadows = widget.customShadows ?? defaultShadows;

    Widget cardContent = Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.glassmorphic ? Colors.transparent : cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: cardBorder,
      ),
      child: widget.child,
    );

    if (widget.glassmorphic) {
      cardContent = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: cardBorder,
            ),
            child: widget.child,
          ),
        ),
      );
    }

    Widget animatedCard = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: cardShadows,
          ),
          child: cardContent,
        ),
      ),
    );

    return animatedCard;
  }
}
