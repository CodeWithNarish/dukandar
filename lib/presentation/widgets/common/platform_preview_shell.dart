// lib/presentation/widgets/common/platform_preview_shell.dart

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

enum DeviceMode {
  desktop,
  iphone,
  android,
}

class PlatformPreviewShell extends StatefulWidget {
  final Widget child;

  const PlatformPreviewShell({
    super.key,
    required this.child,
  });

  @override
  State<PlatformPreviewShell> createState() => _PlatformPreviewShellState();
}

class _PlatformPreviewShellState extends State<PlatformPreviewShell> {
  DeviceMode _currentMode = DeviceMode.iphone; // Default to iPhone preview on desktop web

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 768;

        // If running on actual mobile device or narrow screen, bypass shell and show full screen mobile layout
        if (isNarrow) {
          return Scaffold(
            body: widget.child,
          );
        }

        // On desktop web/large screen, show the premium device simulator wrapper
        return Scaffold(
          backgroundColor: const Color(0xFF0F0F1A), // Sleek cosmic background
          body: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.5, -0.3),
                radius: 1.2,
                colors: [
                  Color(0xFF1E1B4B), // Indigo dark
                  Color(0xFF0F0F1A), // Cosmic black
                ],
              ),
            ),
            child: Column(
              children: [
                // Top control/switcher panel
                _buildTopSimulatorControlPanel(),
                
                // Active Simulator Workspace
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: _buildDevicePreview(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopSimulatorControlPanel() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(color: Color(0xFF2E2E48), width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          Row(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 38,
                height: 38,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.storefront_rounded,
                  color: Colors.tealAccent,
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DUKANDAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'Premium Calculator Hub',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Switcher Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F1A),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF2E2E48)),
            ),
            child: Row(
              children: [
                _buildSwitcherTab(DeviceMode.iphone, Icons.phone_iphone_rounded, 'iPhone'),
                _buildSwitcherTab(DeviceMode.android, Icons.android_rounded, 'Android'),
                _buildSwitcherTab(DeviceMode.desktop, Icons.desktop_windows_rounded, 'Desktop'),
              ],
            ),
          ),

          // Quick Action Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.withOpacity(0.4)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Live Simulator',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitcherTab(DeviceMode mode, IconData icon, String label) {
    final isSelected = _currentMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentMode = mode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E2E48) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.tealAccent : Colors.white60,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevicePreview() {
    switch (_currentMode) {
      case DeviceMode.iphone:
        return _buildIphoneMockup();
      case DeviceMode.android:
        return _buildAndroidMockup();
      case DeviceMode.desktop:
        return _buildDesktopMockup();
    }
  }

  // --- iPhone 15 Pro Max Mockup ---
  Widget _buildIphoneMockup() {
    return Container(
      width: 410,
      height: 840,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFF333333), width: 12), // Device Bezel
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Stack(
          children: [
            // Embedded Flutter app
            Positioned.fill(
              child: widget.child,
            ),

            // Top Status Bar Overlay (iOS design)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 44,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_alt_rounded, color: Colors.white, size: 13),
                        SizedBox(width: 4),
                        Icon(Icons.wifi, color: Colors.white, size: 13),
                        SizedBox(width: 4),
                        Icon(Icons.battery_5_bar_rounded, color: Colors.white, size: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Dynamic Island
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 110,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            // Bottom iOS Home Indicator
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 140,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Android (Google Pixel style) Mockup ---
  Widget _buildAndroidMockup() {
    return Container(
      width: 420,
      height: 870,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF1E1E1E), width: 10), // Device Bezel
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Embedded Flutter app
            Positioned.fill(
              child: widget.child,
            ),

            // Top Status Bar Overlay (Android design)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 38,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.black.withOpacity(0.1),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10:30 AM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.wifi, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Icon(Icons.network_cell_rounded, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Icon(Icons.battery_full_rounded, color: Colors.white, size: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Punch-hole Camera
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Bottom Android Navigation bar pill
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Premium macOS/Windows Desktop Mockup ---
  Widget _buildDesktopMockup() {
    return Container(
      width: 1100,
      height: 720,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E2E48), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Window Header (macOS style)
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: const Color(0xFF16162A),
              child: Row(
                children: [
                  // Red / Yellow / Green Window Controls
                  const Row(
                    children: [
                      CircleAvatar(radius: 6, backgroundColor: Color(0xFFFF5F56)),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 6, backgroundColor: Color(0xFFFFBD2E)),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 6, backgroundColor: Color(0xFF27C93F)),
                    ],
                  ),
                  
                  // Title
                  Expanded(
                    child: Center(
                      child: Text(
                        'Dukandar Premium Dashboard (Desktop View)',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  // Spacer to balance window controls
                  const SizedBox(width: 52),
                ],
              ),
            ),
            
            // Embedded Flutter app
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
