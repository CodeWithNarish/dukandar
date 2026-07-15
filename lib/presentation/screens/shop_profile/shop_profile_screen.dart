// lib/presentation/screens/shop_profile/shop_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/localization_helper.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../providers/shop_profile_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/common/premium_card.dart';
import '../../widgets/common/premium_text_field.dart';
import '../../widgets/common/unit_selector.dart';

class ShopProfileScreen extends ConsumerStatefulWidget {
  const ShopProfileScreen({super.key});

  @override
  ConsumerState<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends ConsumerState<ShopProfileScreen> {
  late TextEditingController _shopNameController;
  late TextEditingController _ownerNameController;
  String _defaultCurrency = '₹';
  String _defaultWeightUnit = 'KG';
  String _selectedAvatar = 'grocery';
  bool _initialized = false;

  static const List<Map<String, dynamic>> _avatars = [
    {'id': 'logo', 'icon': Icons.image_rounded, 'color': Colors.teal, 'label': 'App Logo'},
    {'id': 'grocery', 'icon': Icons.local_grocery_store_rounded, 'color': Colors.orange, 'label': 'Grocery/Kirana'},
    {'id': 'sweets', 'icon': Icons.cake_rounded, 'color': Colors.pink, 'label': 'Sweet Shop/Bakery'},
    {'id': 'dairy', 'icon': Icons.water_drop_rounded, 'color': Colors.blue, 'label': 'Dairy'},
    {'id': 'fruits', 'icon': Icons.eco_rounded, 'color': Colors.green, 'label': 'Fruits & Veg'},
    {'id': 'hardware', 'icon': Icons.handyman_rounded, 'color': Colors.blueGrey, 'label': 'Hardware'},
    {'id': 'medical', 'icon': Icons.local_pharmacy_rounded, 'color': Colors.red, 'label': 'Medical'},
    {'id': 'stationery', 'icon': Icons.edit_rounded, 'color': Colors.indigo, 'label': 'Stationery'},
  ];

  @override
  void initState() {
    super.initState();
    _shopNameController = TextEditingController();
    _ownerNameController = TextEditingController();
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';
    final profileAsync = ref.watch(shopProfileNotifierProvider);

    // Initialize controllers from profile data once
    profileAsync.whenData((profile) {
      if (!_initialized) {
        _shopNameController.text = profile.shopName;
        _ownerNameController.text = profile.ownerName;
        _defaultCurrency = profile.defaultCurrency;
        _defaultWeightUnit = profile.defaultWeightUnit;
        _selectedAvatar = profile.logoPath ?? 'logo';
        _initialized = true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('shop_profile', lang)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop Avatar Selection
              Text(
                LocalizationHelper.translate('select_avatar', lang),
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemCount: _avatars.length,
                itemBuilder: (context, index) {
                  final avatar = _avatars[index];
                  final isSelected = _selectedAvatar == avatar['id'];
                  final Color avatarColor = avatar['color'] as Color;
                  final isLogo = avatar['id'] == 'logo';

                  return GestureDetector(
                    onTap: () {
                      setState(() { _selectedAvatar = avatar['id']; });
                      HapticHelper.selectionClick();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? avatarColor.withOpacity(0.15)
                            : (isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02)),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? avatarColor : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLogo
                              ? ClipOval(
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Icon(avatar['icon'] as IconData, color: avatarColor, size: 28),
                                  ),
                                )
                              : Icon(avatar['icon'] as IconData, color: avatarColor, size: 28),
                          const SizedBox(height: 4),
                          Text(
                            (avatar['label'] as String).split('/').first,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Shop Details
              Text(
                LocalizationHelper.translate('shop_details', lang),
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              PremiumTextField(
                controller: _shopNameController,
                label: lang == 'hi' ? 'दुकान का नाम' : 'Shop Name',
                hint: 'e.g., Sharma General Store',
              ),
              const SizedBox(height: 12),

              PremiumTextField(
                controller: _ownerNameController,
                label: LocalizationHelper.translate('owner_name', lang),
                hint: 'e.g., Raj Sharma',
              ),
              const SizedBox(height: 16),

              // Default Unit
              UnitSelector(
                label: LocalizationHelper.translate('default_weight_unit', lang),
                selected: _defaultWeightUnit,
                onChanged: (val) {
                  setState(() { _defaultWeightUnit = val; });
                },
              ),
              const SizedBox(height: 28),

              // Save Button
              ElevatedButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.save_rounded),
                label: Text(LocalizationHelper.translate('save', lang)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    final settingsAsync = ref.read(settingsNotifierProvider);
    final lang = settingsAsync.value?.language ?? 'en';

    ref.read(shopProfileNotifierProvider.notifier).updateProfile(
      shopName: _shopNameController.text.trim().isEmpty
          ? 'Dukandar Shop'
          : _shopNameController.text.trim(),
      ownerName: _ownerNameController.text.trim().isEmpty
          ? 'Owner'
          : _ownerNameController.text.trim(),
      defaultCurrency: _defaultCurrency,
      defaultWeightUnit: _defaultWeightUnit,
      logoPath: _selectedAvatar,
    );

    HapticHelper.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocalizationHelper.translate('profile_saved', lang))),
    );
  }
}
