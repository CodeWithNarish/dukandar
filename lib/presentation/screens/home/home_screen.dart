// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../app/theme/app_colors.dart';
import '../../providers/product_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/shop_profile_provider.dart';
import '../../providers/calculator_provider.dart';
import '../../widgets/common/premium_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Watch settings and profile providers
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final profileAsync = ref.watch(shopProfileNotifierProvider);
    final favoritesAsync = ref.watch(favoriteProductsProvider);

    final lang = settingsAsync.value?.language ?? 'en';
    final shopName = profileAsync.value?.shopName ?? 'Dukandar Shop';
    final ownerName = profileAsync.value?.ownerName ?? 'Owner';
    final avatarId = profileAsync.value?.logoPath ?? 'logo';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context, shopName, ownerName, avatarId, lang),
              const SizedBox(height: 24),

              // Favorites Section
              Text(
                LocalizationHelper.translate('favorites', lang),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildFavorites(context, ref, favoritesAsync, lang),
              const SizedBox(height: 28),

              // Grid Section Title
              Text(
                LocalizationHelper.translate('quick_access', lang),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildGrid(context, lang),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, lang),
    );
  }

  Widget _buildHeader(BuildContext context, String shopName, String ownerName, String avatarId, String lang) {
    final theme = Theme.of(context);
    
    // Choose icon based on selected avatarId
    IconData avatarIcon = Icons.storefront_rounded;
    Color avatarColor = theme.colorScheme.primary;
    
    switch (avatarId) {
      case 'grocery':
        avatarIcon = Icons.local_grocery_store_rounded;
        avatarColor = Colors.orange;
        break;
      case 'sweets':
        avatarIcon = Icons.cake_rounded;
        avatarColor = Colors.pink;
        break;
      case 'dairy':
        avatarIcon = Icons.water_drop_rounded;
        avatarColor = Colors.blue;
        break;
      case 'fruits':
        avatarIcon = Icons.eco_rounded;
        avatarColor = Colors.green;
        break;
      case 'hardware':
        avatarIcon = Icons.handyman_rounded;
        avatarColor = Colors.blueGrey;
        break;
      case 'medical':
        avatarIcon = Icons.local_pharmacy_rounded;
        avatarColor = Colors.red;
        break;
      case 'stationery':
        avatarIcon = Icons.edit_rounded;
        avatarColor = Colors.indigo;
        break;
      case 'logo':
        avatarIcon = Icons.image_rounded;
        avatarColor = Colors.teal;
        break;
      default:
        avatarIcon = Icons.storefront_rounded;
        avatarColor = theme.colorScheme.primary;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: avatarColor.withOpacity(0.15),
              child: avatarId == 'logo'
                  ? ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.storefront_rounded, color: avatarColor, size: 28),
                      ),
                    )
                  : Icon(avatarIcon, color: avatarColor, size: 28),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ownerName,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            HapticHelper.lightImpact();
            context.push('/profile');
          },
          icon: const Icon(Icons.account_circle_outlined, size: 28),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1);
  }

  Widget _buildFavorites(BuildContext context, WidgetRef ref, AsyncValue<List<dynamic>> favoritesAsync, String lang) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return favoritesAsync.when(
      data: (favorites) {
        if (favorites.isEmpty) {
          return PremiumCard(
            glassmorphic: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Icon(Icons.star_outline_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocalizationHelper.translate('no_favorites', lang),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }

        return SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 130,
                child: PremiumCard(
                  glassmorphic: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  onTap: () {
                    // prefill calculator state
                    ref.read(priceToWeightCalculatorProvider.notifier).prefillFromProduct(product);
                    ref.read(productListProvider.notifier).incrementUsage(product.id);
                    context.push('/price-to-weight');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price}/${product.unit}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildGrid(BuildContext context, String lang) {
    final items = [
      _GridItem(
        titleKey: 'price_to_weight',
        subtitleKey: 'price_to_weight_sub',
        icon: Icons.scale_rounded,
        color: Colors.blue,
        route: '/price-to-weight',
      ),
      _GridItem(
        titleKey: 'weight_to_price',
        subtitleKey: 'weight_to_price_sub',
        icon: Icons.currency_rupee_rounded,
        color: Colors.green,
        route: '/weight-to-price',
      ),
      _GridItem(
        titleKey: 'profit_calc',
        subtitleKey: 'profit_calc_sub',
        icon: Icons.trending_up_rounded,
        color: Colors.teal,
        route: '/profit',
      ),
      _GridItem(
        titleKey: 'discount_calc',
        subtitleKey: 'discount_calc_sub',
        icon: Icons.percent_rounded,
        color: Colors.orange,
        route: '/discount',
      ),
      _GridItem(
        titleKey: 'gst_calc',
        subtitleKey: 'gst_calc_sub',
        icon: Icons.receipt_long_rounded,
        color: Colors.red,
        route: '/gst',
      ),
      _GridItem(
        titleKey: 'prod_lib',
        subtitleKey: 'prod_lib_sub',
        icon: Icons.inventory_rounded,
        color: Colors.purple,
        route: '/products',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PremiumCard(
          glassmorphic: true,
          padding: const EdgeInsets.all(12),
          onTap: () => context.push(item.route),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: item.color.withOpacity(0.12),
                child: Icon(item.icon, color: item.color, size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizationHelper.translate(item.titleKey, lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocalizationHelper.translate(item.subtitleKey, lang),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ).animate()
         .fadeIn(delay: (index * 50).ms, duration: 300.ms)
         .scale(begin: const Offset(0.9, 0.9));
      },
    );
  }

  Widget _buildBottomNav(BuildContext context, String lang) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavItem(
            icon: Icons.home_rounded,
            label: LocalizationHelper.translate('home', lang),
            isActive: true,
            onTap: () {},
          ),
          _BottomNavItem(
            icon: Icons.history_rounded,
            label: LocalizationHelper.translate('history', lang),
            isActive: false,
            onTap: () {
              HapticHelper.lightImpact();
              context.push('/history');
            },
          ),
          _BottomNavItem(
            icon: Icons.settings_rounded,
            label: LocalizationHelper.translate('settings', lang),
            isActive: false,
            onTap: () {
              HapticHelper.lightImpact();
              context.push('/settings');
            },
          ),
        ],
      ),
    );
  }
}

class _GridItem {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final Color color;
  final String route;

  _GridItem({
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isActive ? theme.colorScheme.primary : theme.textTheme.labelLarge?.color;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
