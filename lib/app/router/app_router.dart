// lib/app/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/price_to_weight/price_to_weight_screen.dart';
import '../../presentation/screens/weight_to_price/weight_to_price_screen.dart';
import '../../presentation/screens/profit_calculator/profit_calculator_screen.dart';
import '../../presentation/screens/discount_calculator/discount_calculator_screen.dart';
import '../../presentation/screens/gst_calculator/gst_calculator_screen.dart';
import '../../presentation/screens/product_library/product_library_screen.dart';
import '../../presentation/screens/history/history_screen.dart';
import '../../presentation/screens/shop_profile/shop_profile_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/widgets/common/platform_preview_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return PlatformPreviewShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/price-to-weight',
          builder: (context, state) => const PriceToWeightScreen(),
        ),
        GoRoute(
          path: '/weight-to-price',
          builder: (context, state) => const WeightToPriceScreen(),
        ),
        GoRoute(
          path: '/profit',
          builder: (context, state) => const ProfitCalculatorScreen(),
        ),
        GoRoute(
          path: '/discount',
          builder: (context, state) => const DiscountCalculatorScreen(),
        ),
        GoRoute(
          path: '/gst',
          builder: (context, state) => const GstCalculatorScreen(),
        ),
        GoRoute(
          path: '/products',
          builder: (context, state) => const ProductLibraryScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ShopProfileScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
