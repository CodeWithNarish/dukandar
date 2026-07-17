// lib/presentation/screens/land_calculator/land_calculator_screen.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../data/models/land_field_model.dart';
import '../../providers/land_provider.dart';
import '../../widgets/common/premium_card.dart';

class LandCalculatorScreen extends ConsumerStatefulWidget {
  const LandCalculatorScreen({super.key});

  @override
  ConsumerState<LandCalculatorScreen> createState() => _LandCalculatorScreenState();
}

class _LandCalculatorScreenState extends ConsumerState<LandCalculatorScreen>
    with TickerProviderStateMixin {
  final _fieldNameCtrl = TextEditingController();
  final _length1Ctrl = TextEditingController();
  final _length2Ctrl = TextEditingController();
  final _width1Ctrl = TextEditingController();
  final _width2Ctrl = TextEditingController();
  final _conversionCtrl = TextEditingController(text: '27225');
  final _notesCtrl = TextEditingController();

  String _measureUnit = 'feet';   // feet, meter, yard
  String _localUnit = 'bigha';    // bigha, acre, hectare, sqft, sqmeter, sqyard

  // Calculated values
  double _areaSqFt = 0;
  double _areaSqMeter = 0;
  double _areaSqYard = 0;
  double _areaAcre = 0;
  double _areaHectare = 0;
  double _areaLocalUnit = 0;

  bool _hasResult = false;
  bool _settingsSaved = false;

  late AnimationController _resultAnimController;

  final Map<String, String> _unitLabels = {
    'feet': 'Feet',
    'meter': 'Meter',
    'yard': 'Yard',
  };

  final Map<String, String> _localUnitLabels = {
    'bigha': 'Bigha',
    'acre': 'Acre',
    'hectare': 'Hectare',
    'sqft': 'Square Feet',
    'sqmeter': 'Square Meter',
    'sqyard': 'Square Yard',
  };

  final Map<String, String> _localUnitIcons = {
    'bigha': '🌾',
    'acre': '🌿',
    'hectare': '🌲',
    'sqft': '📐',
    'sqmeter': '📏',
    'sqyard': '🏡',
  };

  @override
  void initState() {
    super.initState();
    _resultAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadSavedSettings();
    _length1Ctrl.addListener(_calculate);
    _length2Ctrl.addListener(_calculate);
    _width1Ctrl.addListener(_calculate);
    _width2Ctrl.addListener(_calculate);
    _conversionCtrl.addListener(_calculate);
  }

  Future<void> _loadSavedSettings() async {
    final settings = await ref.read(landSettingsProvider.future);
    if (mounted) {
      setState(() {
        _measureUnit = settings['measurementUnit'] as String? ?? 'feet';
        _localUnit = settings['localUnit'] as String? ?? 'bigha';
        _conversionCtrl.text = (settings['conversionValue'] as num?)?.toString() ?? '27225';
      });
    }
  }

  @override
  void dispose() {
    _resultAnimController.dispose();
    _fieldNameCtrl.dispose();
    _length1Ctrl.dispose();
    _length2Ctrl.dispose();
    _width1Ctrl.dispose();
    _width2Ctrl.dispose();
    _conversionCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final l1 = double.tryParse(_length1Ctrl.text) ?? 0;
    // If side 2 is empty, assume it's a perfect rectangle
    final l2 = double.tryParse(_length2Ctrl.text) ?? l1;
    
    final w1 = double.tryParse(_width1Ctrl.text) ?? 0;
    final w2 = double.tryParse(_width2Ctrl.text) ?? w1;
    
    final convValue = double.tryParse(_conversionCtrl.text) ?? 0;

    if (l1 <= 0 || w1 <= 0 || convValue <= 0) {
      if (_hasResult) {
        setState(() => _hasResult = false);
      }
      return;
    }

    final avgLength = (l1 + l2) / 2;
    final avgWidth = (w1 + w2) / 2;
    double rawArea = avgLength * avgWidth;
    double sqFt;

    switch (_measureUnit) {
      case 'meter':
        sqFt = rawArea * 10.7639; // 1 sqm = 10.7639 sqft
        break;
      case 'yard':
        sqFt = rawArea * 9.0; // 1 sqyd = 9 sqft
        break;
      default:
        sqFt = rawArea;
    }

    // Now calculate all units from sqFt
    final sqMeter = sqFt / 10.7639;
    final sqYard = sqFt / 9.0;
    final acre = sqFt / 43560.0;
    final hectare = sqFt / 107639.0;

    double localUnitArea;
    switch (_localUnit) {
      case 'acre':
        localUnitArea = acre;
        break;
      case 'hectare':
        localUnitArea = hectare;
        break;
      case 'sqft':
        localUnitArea = sqFt;
        break;
      case 'sqmeter':
        localUnitArea = sqMeter;
        break;
      case 'sqyard':
        localUnitArea = sqYard;
        break;
      default: // bigha (custom conversionValue based on selected unit)
        localUnitArea = rawArea / convValue;
    }

    setState(() {
      _areaSqFt = sqFt;
      _areaSqMeter = sqMeter;
      _areaSqYard = sqYard;
      _areaAcre = acre;
      _areaHectare = hectare;
      _areaLocalUnit = localUnitArea;
      _hasResult = true;
    });

    _resultAnimController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  Future<void> _saveField() async {
    final l1 = double.tryParse(_length1Ctrl.text) ?? 0;
    if (l1 <= 0 || !_hasResult) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid dimensions first')),
      );
      return;
    }

    final field = LandFieldModel(
      fieldName: _fieldNameCtrl.text.isEmpty ? 'My Field' : _fieldNameCtrl.text,
      length1: l1,
      length2: double.tryParse(_length2Ctrl.text) ?? l1,
      width1: double.tryParse(_width1Ctrl.text) ?? 0,
      width2: double.tryParse(_width2Ctrl.text) ?? (double.tryParse(_width1Ctrl.text) ?? 0),
      measurementUnit: _measureUnit,
      localUnit: _localUnit,
      conversionValue: double.tryParse(_conversionCtrl.text) ?? 27225,
      areaSqFt: _areaSqFt,
      localUnitArea: _areaLocalUnit,
      notes: _notesCtrl.text,
    );

    await ref.read(landFieldsProvider.notifier).saveField(field);
    HapticFeedback.mediumImpact();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text('${field.fieldName} saved successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  Future<void> _saveSettings() async {
    final convValue = double.tryParse(_conversionCtrl.text);
    if (convValue == null || convValue <= 0) return;

    await ref.read(landSettingsProvider.notifier).saveSettings({
      'conversionValue': convValue,
      'localUnit': _localUnit,
      'measurementUnit': _measureUnit,
    });

    setState(() => _settingsSaved = true);
    HapticFeedback.mediumImpact();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _settingsSaved = false);
    });
  }

  void _shareResult() {
    if (!_hasResult) return;
    final l1 = _length1Ctrl.text;
    final l2 = _length2Ctrl.text.isEmpty ? l1 : _length2Ctrl.text;
    final w1 = _width1Ctrl.text;
    final w2 = _width2Ctrl.text.isEmpty ? w1 : _width2Ctrl.text;
    
    final unit = _unitLabels[_measureUnit] ?? _measureUnit;
    final localLabel = _localUnitLabels[_localUnit] ?? _localUnit;
    final fieldName = _fieldNameCtrl.text.isEmpty ? 'My Field' : _fieldNameCtrl.text;

    final text = '''
🌾 $fieldName — Land Measurement Report
━━━━━━━━━━━━━━━━━━━━━━━
📐 Dimensions ($unit):
• Length: Side 1 = $l1, Side 2 = $l2
• Width: Side 1 = $w1, Side 2 = $w2
━━━━━━━━━━━━━━━━━━━━━━━
📊 Area Results:
• ${NumberFormatter.format(_areaLocalUnit)} $localLabel
• ${NumberFormatter.format(_areaSqFt)} Square Feet
• ${NumberFormatter.format(_areaSqMeter)} Square Meter
• ${NumberFormatter.format(_areaAcre)} Acre
• ${NumberFormatter.format(_areaHectare)} Hectare
━━━━━━━━━━━━━━━━━━━━━━━
Calculated by Dukandar App 🌾
''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.copy_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Result copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium App Bar
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF0A0A0F) : const Color(0xFFF0FFF4),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                '🌾 Smart Land Calculator',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF0A2E1A), const Color(0xFF0F0F1A)]
                        : [const Color(0xFFD4EDDA), const Color(0xFFE8F5E9)],
                  ),
                ),
                child: Center(
                  child: Text(
                    '🌾',
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => _showSavedFields(),
                icon: const Icon(Icons.folder_open_rounded),
                tooltip: 'Saved Fields',
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Field Name
                  _buildSectionLabel('🏷️ Field Name (Optional)'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _fieldNameCtrl,
                    hint: 'e.g. North Farm, Rice Field...',
                    icon: Icons.label_rounded,
                  ),
                  const SizedBox(height: 20),

                  // Step 1 — Measurement Unit
                  _buildStepCard(
                    step: '01',
                    title: 'Select Measurement Unit',
                    color: Colors.blue,
                    child: _buildSegmentedUnit(),
                  ),
                  const SizedBox(height: 14),

                  // Step 2 & 3 — Length and Width (4 Sides)
                  _buildStepCard(
                    step: '02',
                    title: 'Enter All 4 Sides (in ${_unitLabels[_measureUnit]})',
                    color: Colors.green,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumericField(
                                controller: _length1Ctrl,
                                label: 'Length (Side 1)',
                                hint: '250',
                                suffix: _unitLabels[_measureUnit] ?? '',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildNumericField(
                                controller: _length2Ctrl,
                                label: 'Length (Side 2)',
                                hint: 'Leave blank if same',
                                suffix: _unitLabels[_measureUnit] ?? '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildNumericField(
                                controller: _width1Ctrl,
                                label: 'Width (Side 1)',
                                hint: '180',
                                suffix: _unitLabels[_measureUnit] ?? '',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildNumericField(
                                controller: _width2Ctrl,
                                label: 'Width (Side 2)',
                                hint: 'Leave blank if same',
                                suffix: _unitLabels[_measureUnit] ?? '',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Step 4 — Local Unit
                  _buildStepCard(
                    step: '03',
                    title: 'Select Local Land Unit',
                    color: Colors.orange,
                    child: _buildLocalUnitDropdown(),
                  ),
                  const SizedBox(height: 14),

                  // Step 5 — Conversion Value (only shown for bigha)
                  if (_localUnit == 'bigha' || _localUnit == 'acre' || _localUnit == 'hectare')
                    _buildStepCard(
                      step: '04',
                      title: '1 ${_localUnitLabels[_localUnit]} = ? Sq.${_unitLabels[_measureUnit]}',
                      color: Colors.purple,
                      child: Column(
                        children: [
                          _buildNumericField(
                            controller: _conversionCtrl,
                            label: 'Conversion Value',
                            hint: 'e.g. 843 or 27225',
                            suffix: 'Sq.${_unitLabels[_measureUnit]}',
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildConversionPreset('UP (27225)', 27225),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildConversionPreset('MP (26910)', 26910),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildConversionPreset('RJ (27225)', 27225),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildConversionPreset('PB (9000)', 9000),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildConversionPreset('HR (27225)', 27225),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildConversionPreset('WB (14400)', 14400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _saveSettings,
                              icon: Icon(
                                _settingsSaved ? Icons.check_circle_rounded : Icons.save_rounded,
                              ),
                              label: Text(_settingsSaved ? 'Saved!' : 'Save as Default'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _settingsSaved ? Colors.green : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (_localUnit == 'bigha' || _localUnit == 'acre' || _localUnit == 'hectare')
                    const SizedBox(height: 14),

                  // RESULT CARD
                  if (_hasResult) ...[
                    _buildResultCard(theme, isDark),
                    const SizedBox(height: 14),
                    _buildFormulaCard(theme, isDark),
                    const SizedBox(height: 14),
                    _buildVisualField(theme, isDark),
                    const SizedBox(height: 14),
                    _buildNotesField(),
                    const SizedBox(height: 14),
                    _buildActionButtons(),
                  ],

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildNumericField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffix,
            suffixStyle: const TextStyle(fontSize: 11, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentedUnit() {
    return Row(
      children: ['feet', 'meter', 'yard'].map((unit) {
        final isSelected = _measureUnit == unit;
        final icons = {'feet': Icons.straighten_rounded, 'meter': Icons.square_foot_rounded, 'yard': Icons.crop_square_rounded};
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _measureUnit = unit);
              _calculate();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[unit], size: 20, color: isSelected ? Colors.white : Colors.grey),
                  const SizedBox(height: 4),
                  Text(
                    _unitLabels[unit] ?? unit,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLocalUnitDropdown() {
    return DropdownButtonFormField<String>(
      value: _localUnit,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: _localUnitLabels.entries.map((e) => DropdownMenuItem(
        value: e.key,
        child: Row(
          children: [
            Text(_localUnitIcons[e.key] ?? ''),
            const SizedBox(width: 8),
            Text(e.value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      )).toList(),
      onChanged: (val) {
        if (val != null) {
          setState(() => _localUnit = val);
          _calculate();
        }
      },
    );
  }

  Widget _buildConversionPreset(String label, double value) {
    return GestureDetector(
      onTap: () {
        _conversionCtrl.text = value.toInt().toString();
        _calculate();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.purple.withOpacity(0.2)),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.purple)),
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required Color color,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildResultCard(ThemeData theme, bool isDark) {
    final localLabel = _localUnitLabels[_localUnit] ?? _localUnit;
    final localIcon = _localUnitIcons[_localUnit] ?? '🌾';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF0A2E1A), const Color(0xFF1A3A2A)]
              : [const Color(0xFF2E7D32), const Color(0xFF43A047)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🌾', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fieldNameCtrl.text.isEmpty ? 'Field Area' : _fieldNameCtrl.text,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        '${NumberFormatter.format(_areaSqFt)} Sq.Ft',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(color: Colors.white24, height: 28),

            // Primary result (local unit)
            Row(
              children: [
                Text(localIcon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  '${NumberFormatter.format(_areaLocalUnit)} $localLabel',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // All conversions grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
              children: [
                if (_localUnit != 'acre') _buildMiniResult('Acre', NumberFormatter.format(_areaAcre), '🌿'),
                if (_localUnit != 'hectare') _buildMiniResult('Hectare', NumberFormatter.format(_areaHectare), '🌲'),
                if (_localUnit != 'sqft') _buildMiniResult('Sq.Feet', NumberFormatter.format(_areaSqFt), '📐'),
                if (_localUnit != 'sqmeter') _buildMiniResult('Sq.Meter', NumberFormatter.format(_areaSqMeter), '📏'),
                if (_localUnit != 'sqyard') _buildMiniResult('Sq.Yard', NumberFormatter.format(_areaSqYard), '🏡'),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildMiniResult(String label, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaCard(ThemeData theme, bool isDark) {
    final l1 = double.tryParse(_length1Ctrl.text) ?? 0;
    final l2 = double.tryParse(_length2Ctrl.text) ?? l1;
    final w1 = double.tryParse(_width1Ctrl.text) ?? 0;
    final w2 = double.tryParse(_width2Ctrl.text) ?? w1;
    
    final avgL = (l1 + l2) / 2;
    final avgW = (w1 + w2) / 2;
    final rawArea = avgL * avgW;
    
    final unit = _unitLabels[_measureUnit] ?? _measureUnit;
    final localLabel = _localUnitLabels[_localUnit] ?? _localUnit;
    final convVal = double.tryParse(_conversionCtrl.text) ?? 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.functions_rounded, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text('Calculation Formula', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
          const SizedBox(height: 14),
          _formulaLine('Avg Length: ($l1 + $l2) ÷ 2', '= ${NumberFormatter.format(avgL)} $unit'),
          const SizedBox(height: 4),
          _formulaLine('Avg Width: ($w1 + $w2) ÷ 2', '= ${NumberFormatter.format(avgW)} $unit'),
          const Divider(height: 16),
          _formulaLine('Total Area ($avgL × $avgW)', '= ${NumberFormatter.format(rawArea)} Sq.$unit'),
          const SizedBox(height: 8),
          
          if (_localUnit == 'bigha')
            _formulaLine('${NumberFormatter.format(rawArea)} ÷ $convVal', '= ${NumberFormatter.format(_areaLocalUnit)} $localLabel'),
          if (_localUnit == 'acre' && _measureUnit == 'feet')
            _formulaLine('${NumberFormatter.format(_areaSqFt)} ÷ 43560', '= ${NumberFormatter.format(_areaAcre)} Acre'),
          if (_localUnit == 'hectare' && _measureUnit == 'feet')
            _formulaLine('${NumberFormatter.format(_areaSqFt)} ÷ 107639', '= ${NumberFormatter.format(_areaHectare)} Hectare'),
        ],
      ),
    );
  }

  Widget _formulaLine(String left, String right) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(left, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.orange),
          const SizedBox(width: 8),
          Text(right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildVisualField(ThemeData theme, bool isDark) {
    final l1 = double.tryParse(_length1Ctrl.text) ?? 0;
    final l2 = double.tryParse(_length2Ctrl.text) ?? l1;
    final w1 = double.tryParse(_width1Ctrl.text) ?? 0;
    final w2 = double.tryParse(_width2Ctrl.text) ?? w1;
    
    final avgL = (l1 + l2) / 2;
    final avgW = (w1 + w2) / 2;
    final unit = _unitLabels[_measureUnit] ?? _measureUnit;
    final maxDim = math.max(avgL, avgW);
    if (maxDim == 0) return const SizedBox.shrink();
    final scaleL = avgL / maxDim;
    final scaleW = avgW / maxDim;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.crop_square_rounded, color: Colors.teal, size: 20),
              SizedBox(width: 8),
              Text('Field Visualization', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 160,
              child: AspectRatio(
                aspectRatio: scaleL / scaleW,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.withOpacity(0.2),
                        Colors.teal.withOpacity(0.3),
                      ],
                    ),
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    children: [
                      // Top label (l1)
                      Positioned(
                        top: 4, left: 0, right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$l1 $unit',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Bottom label (l2)
                      Positioned(
                        bottom: 4, left: 0, right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$l2 $unit',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Left label (w1)
                      Positioned(
                        top: 0, bottom: 0, left: 4,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '$w1 $unit',
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Right label (w2)
                      Positioned(
                        top: 0, bottom: 0, right: 4,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '$w2 $unit',
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Center area text
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🌾', style: TextStyle(fontSize: 24)),
                            Text(
                              'Avg: ${NumberFormatter.format(avgL)} × ${NumberFormatter.format(avgW)}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.notes_rounded, color: Colors.indigo, size: 20),
              SizedBox(width: 8),
              Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _notesCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g. Wheat crop, Ready for harvest...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _saveField,
            icon: const Icon(Icons.bookmark_add_rounded),
            label: const Text('Save Field'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _shareResult,
            icon: const Icon(Icons.share_rounded),
            label: const Text('Copy & Share'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ],
    );
  }

  void _showSavedFields() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _SavedFieldsSheet(
        onFieldSelected: (field) {
          Navigator.pop(ctx);
          _fieldNameCtrl.text = field.fieldName;
          _length1Ctrl.text = field.length1.toString();
          _length2Ctrl.text = field.length2.toString();
          _width1Ctrl.text = field.width1.toString();
          _width2Ctrl.text = field.width2.toString();
          _measureUnit = field.measurementUnit;
          _localUnit = field.localUnit;
          _conversionCtrl.text = field.conversionValue.toString();
          _notesCtrl.text = field.notes;
          setState(() {});
          _calculate();
        },
      ),
    );
  }
}

// ---- Saved Fields Bottom Sheet ----
class _SavedFieldsSheet extends ConsumerWidget {
  final void Function(LandFieldModel) onFieldSelected;

  const _SavedFieldsSheet({required this.onFieldSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldsAsync = ref.watch(landFieldsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(2)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.folder_open_rounded, color: Colors.green),
                SizedBox(width: 10),
                Text('Saved Fields', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: fieldsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (fields) => fields.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🌾', style: TextStyle(fontSize: 48)),
                          SizedBox(height: 12),
                          Text('No fields saved yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: fields.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (ctx, index) {
                        final field = fields[index];
                        return GestureDetector(
                          onTap: () => onFieldSelected(field),
                          child: PremiumCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('🌾', style: TextStyle(fontSize: 24)),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            field.fieldName.isEmpty ? 'My Field' : field.fieldName,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          Text(
                                            'L: ${field.length1}x${field.length2}, W: ${field.width1}x${field.width2} ${field.measurementUnit}',
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          NumberFormatter.format(field.areaSqFt),
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                        ),
                                        const Text('Sq.Ft', style: TextStyle(color: Colors.grey, fontSize: 11)),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: Icon(
                                        field.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                        color: field.isFavorite ? Colors.red : Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () => ref.read(landFieldsProvider.notifier).toggleFavorite(field.id),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_rounded, color: Colors.red, size: 20),
                                      onPressed: () async {
                                        await ref.read(landFieldsProvider.notifier).deleteField(field.id);
                                      },
                                    ),
                                  ],
                                ),
                                if (field.notes.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(field.notes, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
