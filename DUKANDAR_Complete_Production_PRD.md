# 🏪 DUKANDAR - Premium Business Calculator — Complete Production PRD

**App Name:** Dukandar (दुकानदार)  
**Category:** Business Utility / Offline Calculator  
**Platform:** Android (Flutter)  
**Tech Stack:** Flutter + Riverpod + Isar  
**Target Users:** Indian Shopkeepers (Kirana, Grocery, Fruit/Veg, Dairy, Sweet, Bakery, Hardware, Stationery, Medical, Wholesale)  
**Priority:** Production-Grade — 100% Offline  
**Date:** March 20, 2026  
**Status:** Full Implementation Guide

---

## 📋 TABLE OF CONTENTS

```
1. PROJECT OVERVIEW & PROBLEM STATEMENT
2. TECH STACK & ARCHITECTURE
3. DESIGN SYSTEM (Apple-Inspired Premium UI)
4. COMPLETE FEATURE SPECIFICATIONS
5. CORE CALCULATION ENGINE (Formulas)
6. LOCAL DATABASE SCHEMA (Isar)
7. STATE MANAGEMENT (Riverpod)
8. SCREEN-BY-SCREEN UI SPECIFICATIONS
9. ANIMATIONS & MICRO-INTERACTIONS
10. SECURITY & PERFORMANCE
11. VERSION 1 SCOPE (STRICT BOUNDARIES)
12. BUILD & DEPLOYMENT GUIDE
```

---

## 1. PROJECT OVERVIEW & PROBLEM STATEMENT

### 1.1 The Real Problem

```yaml
Problem Statement:
  Millions of Indian shopkeepers face this daily struggle:
  
  "Customer wants ₹35 worth of Rice.
   Rice costs ₹80/KG.
   How many grams should I give?"
  
  Currently shopkeepers:
    ❌ Do mental math (error-prone)
    ❌ Use pen & paper
    ❌ Use normal calculator (still need manual formula)
    ❌ Guess and estimate (lose money or upset customers)

Our Solution:
  ✅ Type price + amount → INSTANT weight result
  ✅ Type weight + price → INSTANT amount result
  ✅ Zero manual formula calculation
  ✅ Works 100% OFFLINE
  ✅ Built for ONE-HAND, FAST daily use

Example Flow:
  Input: Rice = ₹80/KG, Customer pays ₹35
  Output: 437.5 Gram (instant, animated)
```

### 1.2 Why This App Wins

```yaml
Differentiators:
  1. NOT a generic calculator — solves ONE specific pain point perfectly
  2. Premium Apple-style UI (most business apps in India look cheap)
  3. Zero internet dependency (works in villages, low-network areas)
  4. Zero login friction (open app → start calculating)
  5. Product memory (save Rice, Sugar, Oil prices once, reuse forever)
  6. History tracking (helpful for daily business review)

Target Audience:
  - Kirana/Grocery store owners
  - Fruit & Vegetable sellers
  - Dairy shop owners
  - Sweet shop / Bakery owners
  - Hardware & Stationery shop owners
  - Medical store owners
  - Wholesale traders
  - Any small business owner dealing in weight/quantity-based pricing

Business Model (Future):
  - V1: Free, fully offline, no ads (trust building)
  - V2+: Premium features (Invoice, Ledger, Cloud backup) — NOT in scope now
```

### 1.3 Core Promise

```yaml
User Should Feel:
  "This is not just a calculator.
   This is my daily business assistant."

Non-Negotiable Principles:
  ✅ INSTANT calculation (no loading, no delay, updates while typing)
  ✅ 100% OFFLINE (no backend, no login, no internet required)
  ✅ PREMIUM feel (Apple-inspired, glassmorphism, smooth animations)
  ✅ EXTREMELY SIMPLE (first-time shopkeeper understands in 10 seconds)
  ✅ ONE-HAND FRIENDLY (large buttons, thumb-reachable layout)
```

---

## 2. TECH STACK & ARCHITECTURE

### 2.1 Complete Tech Stack

```yaml
Framework:
  Flutter: Latest Stable (3.x)
  Dart: Latest Stable (3.x)

Architecture:
  Pattern: Clean Architecture
  Layers: Presentation → Domain → Data

State Management:
  Riverpod: ^2.5.0
  riverpod_generator: ^2.4.0 (code generation)
  flutter_riverpod: ^2.5.0

Local Database:
  Primary Choice: Isar (^3.1.0)
    Reason: Faster queries, better indexing, type-safe, great for
            product library + history with search/sort/filter
  Alternative: Hive (^2.2.3)
    Reason: Simpler, lighter, good for small-medium datasets
  
  DECISION: Use Isar (better long-term for search + sort + history)

Dependency Injection:
  Riverpod providers (no separate DI package needed)

Navigation:
  go_router: ^14.0.0

Animations:
  flutter_animate: ^4.5.0
  lottie: ^3.1.0 (for premium micro-animations)

Haptics:
  flutter/services.dart (HapticFeedback)

Fonts:
  google_fonts: ^6.2.0 (SF Pro alternative: Inter / Poppins)

Utilities:
  intl: ^0.19.0 (number formatting, currency)
  freezed: ^2.5.0 (immutable models)
  json_annotation: ^4.9.0

NO Backend:
  ❌ No REST API
  ❌ No Firebase
  ❌ No Login/Auth
  ❌ No Internet Permission Required

App Size Target: < 20 MB (lightweight, fast install)
```

### 2.2 Clean Architecture Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # MaterialApp/Router setup
│   ├── router/
│   │   └── app_router.dart         # go_router configuration
│   └── theme/
│       ├── app_colors.dart
│       ├── app_typography.dart
│       ├── app_spacing.dart
│       └── app_theme.dart          # Light + Dark ThemeData
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── unit_constants.dart     # KG, Gram, Litre, etc.
│   │   └── category_constants.dart
│   ├── utils/
│   │   ├── calculation_engine.dart # Core math logic
│   │   ├── number_formatter.dart
│   │   ├── date_formatter.dart
│   │   └── haptic_helper.dart
│   ├── extensions/
│   │   └── context_extensions.dart
│   ├── database/
│   │   └── isar_service.dart
│   └── errors/
│       └── app_exceptions.dart
│
├── data/
│   ├── models/
│   │   ├── product_model.dart      # Isar collection
│   │   ├── history_model.dart      # Isar collection
│   │   ├── shop_profile_model.dart # Isar collection
│   │   └── settings_model.dart     # Isar collection
│   ├── datasources/
│   │   ├── product_local_datasource.dart
│   │   ├── history_local_datasource.dart
│   │   ├── shop_local_datasource.dart
│   │   └── settings_local_datasource.dart
│   └── repositories/
│       ├── product_repository_impl.dart
│       ├── history_repository_impl.dart
│       ├── shop_repository_impl.dart
│       └── settings_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── product_entity.dart
│   │   ├── history_entity.dart
│   │   └── calculation_result_entity.dart
│   ├── repositories/
│   │   ├── product_repository.dart      # Abstract
│   │   ├── history_repository.dart      # Abstract
│   │   └── shop_repository.dart         # Abstract
│   └── usecases/
│       ├── calculate_price_to_weight.dart
│       ├── calculate_weight_to_price.dart
│       ├── calculate_profit.dart
│       ├── calculate_discount.dart
│       ├── calculate_gst.dart
│       ├── save_product.dart
│       ├── search_products.dart
│       └── save_history.dart
│
├── presentation/
│   ├── providers/
│   │   ├── product_provider.dart
│   │   ├── history_provider.dart
│   │   ├── calculator_provider.dart
│   │   ├── settings_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── price_to_weight/
│   │   │   ├── price_to_weight_screen.dart
│   │   │   └── widgets/
│   │   ├── weight_to_price/
│   │   │   ├── weight_to_price_screen.dart
│   │   │   └── widgets/
│   │   ├── profit_calculator/
│   │   ├── discount_calculator/
│   │   ├── gst_calculator/
│   │   ├── product_library/
│   │   ├── favorites/
│   │   ├── history/
│   │   ├── shop_profile/
│   │   └── settings/
│   └── widgets/
│       ├── common/
│       │   ├── premium_card.dart
│       │   ├── premium_button.dart
│       │   ├── premium_text_field.dart
│       │   ├── result_display.dart
│       │   └── unit_selector.dart
│       └── animations/
│           └── number_counter_animation.dart
│
└── generated/                      # Isar generated files
```

---

## 3. DESIGN SYSTEM (Apple-Inspired Premium UI)

### 3.1 Design Philosophy

```yaml
Core Pillars:
  1. PREMIUM — Apple Calculator/Wallet app inspired
  2. GLASSMORPHISM — Soft blur, translucent cards
  3. MINIMAL — No clutter, generous whitespace
  4. FAST — Zero-delay perceived performance
  5. ACCESSIBLE — Large text, large touch targets

Inspiration References:
  ✅ Apple Calculator app
  ✅ Apple Wallet
  ✅ Apple Health app cards
  ✅ Stripe Dashboard (clean data cards)
  ✅ Cash App (bold numbers, simple UX)

STRICTLY AVOID:
  ❌ Stock Android Material calculator look
  ❌ Cluttered multi-tab UI
  ❌ Small tap targets
  ❌ Flat, lifeless cards (no shadow/depth)
  ❌ Cheap gradient overload
```

### 3.2 Color System

```yaml
LIGHT THEME:
  background: #F5F5F7          # Apple light gray
  surface: #FFFFFF
  card_bg: #FFFFFF
  card_glass: rgba(255,255,255,0.7)
  
  primary: #007AFF              # iOS blue
  secondary: #34C759            # iOS green (profit/positive)
  danger: #FF3B30                # iOS red (loss/negative)
  warning: #FF9500               # iOS orange
  
  text_primary: #1C1C1E
  text_secondary: #6E6E73
  text_tertiary: #AEAEB2
  
  border: #E5E5EA
  divider: #D1D1D6

DARK THEME:
  background: #000000           # True black (OLED friendly)
  surface: #1C1C1E
  card_bg: #1C1C1E
  card_glass: rgba(28,28,30,0.7)
  
  primary: #0A84FF               # iOS dark blue
  secondary: #30D158             # iOS dark green
  danger: #FF453A                # iOS dark red
  warning: #FF9F0A               # iOS dark orange
  
  text_primary: #FFFFFF
  text_secondary: #8E8E93
  text_tertiary: #636366
  
  border: #38383A
  divider: #2C2C2E

Category Colors (for Product Library):
  rice: #D4A574        # Warm beige
  sugar: #FFFFFF (with border)
  oil: #F4C430          # Golden
  milk: #E8F1F2         # Soft blue-white
  vegetables: #8BC34A   # Green
  fruits: #FF7043       # Orange-red
  dry_fruits: #8D6E63   # Brown
  medicine: #EF5350     # Red
  hardware: #78909C     # Steel gray
  stationery: #5C6BC0   # Indigo
  custom: #AB47BC       # Purple
```

### 3.3 Typography System

```yaml
Font Family:
  Primary: 'Inter' or 'SF Pro Display' (via google_fonts)
  Numbers: Tabular figures (monospace-style numbers for alignment)

Type Scale:
  display_xl: 48px, weight 700, letter-spacing -1  # Big result numbers
  display_large: 36px, weight 700, letter-spacing -0.5
  headline: 28px, weight 700
  title_large: 22px, weight 600
  title: 18px, weight 600
  body_large: 17px, weight 400
  body: 15px, weight 400
  caption: 13px, weight 500
  small: 11px, weight 400

Usage:
  Result Display: display_xl (result number), body (formula breakdown)
  Screen Titles: headline
  Card Titles: title
  Input Labels: caption
  Body Text: body
```

### 3.4 Spacing & Radius System

```yaml
Spacing Scale (4px base):
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px

Screen Padding: 20px horizontal, 16px vertical

Border Radius:
  button: 14px
  input_field: 14px
  card: 20px
  large_card: 24px
  bottom_sheet: 28px (top corners only)
  chip/badge: 999px (full pill)

Touch Targets:
  minimum: 48x48px
  primary_button_height: 56px
  large_home_card: 120px height minimum
```

### 3.5 Shadow & Glassmorphism System

```yaml
Card Shadow (Light Theme):
  offset: (0, 4)
  blur: 16
  color: rgba(0,0,0,0.06)

Card Shadow (Dark Theme):
  offset: (0, 4)
  blur: 16
  color: rgba(0,0,0,0.4)

Glassmorphism Card:
  background: card_glass (translucent)
  backdrop_filter: blur(20px)
  border: 1px solid rgba(255,255,255,0.1) [dark] / rgba(0,0,0,0.05) [light]
  border_radius: 20px

Elevated Result Card:
  background: gradient (primary → primary.darken(10%))
  shadow: offset(0,8), blur(24), color: primary.withOpacity(0.3)
  border_radius: 24px
```

### 3.6 Animation System

```yaml
Durations:
  instant: 100ms
  fast: 200ms
  normal: 300ms
  slow: 450ms

Curves:
  standard: Curves.easeOutCubic
  bounce: Curves.elasticOut
  sharp: Curves.easeInOut

Key Animations:
  1. Number Counter:
     - Animate result number counting up/down
     - Duration: 300ms
     - Curve: easeOutCubic
  
  2. Card Tap:
     - Scale: 1.0 → 0.97 → 1.0
     - Duration: 150ms
  
  3. Page Transition:
     - Fade + Slide (from right)
     - Duration: 300ms
  
  4. Result Reveal:
     - Fade in + Scale (0.9 → 1.0)
     - Duration: 400ms
     - Trigger: On calculation update
  
  5. Bottom Sheet:
     - Slide up + fade
     - Duration: 300ms
     - Curve: easeOutCubic
  
  6. Success Feedback (Save/Delete):
     - Checkmark scale-bounce
     - Haptic: light impact

Haptic Feedback Map:
  - Button tap: HapticFeedback.lightImpact()
  - Calculation complete: HapticFeedback.selectionClick()
  - Save success: HapticFeedback.mediumImpact()
  - Delete/Error: HapticFeedback.heavyImpact()
```

---

## 4. COMPLETE FEATURE SPECIFICATIONS

### 4.1 Home Screen

```yaml
Layout:
  1. Header:
     - Shop name (if set) or "Dukandar" logo
     - Settings icon (top-right)
  
  2. Quick Access Row (Favorites):
     - Horizontal scroll of favorite products
     - Tap → instant calculator with pre-filled price
  
  3. Main Business Cards Grid (2 columns):
     Card 1: Price → Weight (icon: scale/weight)
     Card 2: Weight → Price (icon: rupee/weight)
     Card 3: Profit Calculator (icon: trending-up)
     Card 4: Discount Calculator (icon: tag)
     Card 5: GST Calculator (icon: receipt)
     Card 6: Product Library (icon: box)
  
  4. Bottom Row:
     - History (icon: clock)
     - Settings (icon: gear)

Card Design:
  - Large tap area (min 150dp height)
  - Icon (top, 40dp, colored)
  - Title (bold, 18px)
  - Subtitle (small hint text, 13px, secondary color)
  - Glassmorphism background
  - Subtle shadow
  - Scale animation on tap

Empty State (No favorites yet):
  - Friendly message: "Pin your frequent products here for 1-tap access"
```

### 4.2 Price → Weight Calculator (CORE FEATURE)

```yaml
Screen Flow:
  1. Product Name (optional text field)
     - Autocomplete from saved Product Library
  
  2. Product Price Input
     - Large numeric input
     - Currency prefix (₹)
     - Example: 80
  
  3. Unit Selector (chip/dropdown)
     Options: KG, Gram, Litre, ML, Piece, Dozen, Meter, Feet, Packet, Bottle, Bag
  
  4. Base Quantity Input
     - Numeric input
     - Default: 1 (matches selected unit)
     - Example: 1 (KG)
  
  5. Customer Amount Input
     - Large numeric input
     - Currency prefix (₹)
     - Example: 35
  
  6. RESULT (auto-updates while typing, ZERO delay):
     Large Animated Number: "437.5 Gram"
     Rounded Value (secondary): "≈ 438 Gram"
     
     Formula Breakdown (collapsible/small text):
       ₹80 ÷ 1000g = ₹0.08 per gram
       ₹35 ÷ ₹0.08 = 437.5 Gram

Interaction Rules:
  ✅ NO calculate button — updates LIVE as user types
  ✅ NO loading spinner — instant math (client-side, offline)
  ✅ Debounce: NONE needed (pure math, no async operation)
  ✅ If product selected from library → auto-fill price + unit

Bottom Actions:
  - "Save to History" (auto-saves by default, this is optional manual save)
  - "Save as Product" (if name entered but not in library)
  - "Copy Result" (copies "437.5 Gram" to clipboard)

Edge Cases:
  - Price = 0 → Show "Enter a valid price"
  - Amount > implied max → Show result anyway (no artificial cap)
  - Non-numeric input → Prevented at input level (numeric keyboard only)
```

### 4.3 Weight → Price Calculator

```yaml
Screen Flow:
  1. Product Name (optional, autocomplete)
  2. Product Price (₹80/KG)
  3. Unit Selector
  4. Base Quantity (1 KG)
  5. Customer Weight Input (750 Gram)
  6. RESULT: "₹60" (large, animated, real-time)
     Formula: ₹80 ÷ 1000g × 750g = ₹60

Same interaction rules as Price → Weight (live update, no button)
```

### 4.4 Profit Calculator

```yaml
Inputs:
  - Cost Price (₹)
  - Selling Price (₹)

Outputs (auto-calculated, live):
  - Profit/Loss Amount: ₹X (green if profit, red if loss)
  - Profit/Loss %: X%
  - Margin %: X%

Formulas:
  profit = selling_price - cost_price
  profit_percent = (profit / cost_price) × 100
  margin_percent = (profit / selling_price) × 100

UI:
  - Two input cards (Cost, Selling)
  - Result card below (color-coded: green=profit, red=loss)
  - Icon changes: 📈 (profit) / 📉 (loss)
```

### 4.5 Discount Calculator

```yaml
Inputs:
  - Original Price (₹)
  - Discount % (slider + numeric input)

Outputs (live):
  - Discount Amount: ₹X
  - Final Price: ₹X
  - Total Savings: ₹X

Formulas:
  discount_amount = original_price × (discount_percent / 100)
  final_price = original_price - discount_amount

UI:
  - Slider for discount % (0-100, with numeric override)
  - Large final price display
  - "You Save ₹X" badge
```

### 4.6 GST Calculator

```yaml
Inputs:
  - Amount (₹)
  - GST % (common presets: 5%, 12%, 18%, 28% + custom)
  - Mode Toggle: "Add GST" / "Remove GST" (amount is inclusive)

Outputs (live):
  Add Mode:
    - GST Value: ₹X
    - Final Amount (incl. GST): ₹X
  
  Remove Mode (reverse GST from inclusive amount):
    - Base Amount (excl. GST): ₹X
    - GST Value: ₹X

Formulas:
  Add: gst_value = amount × (gst_percent / 100)
       final = amount + gst_value
  
  Remove: base_amount = amount / (1 + gst_percent/100)
          gst_value = amount - base_amount

UI:
  - GST % preset chips (5/12/18/28/Custom)
  - Toggle switch: Add / Remove
  - Result card
```

### 4.7 Product Library

```yaml
Fields per Product:
  - Product ID (auto)
  - Name (required)
  - Category (dropdown: Rice, Sugar, Oil, Milk, Vegetables, Fruits,
              Dry Fruits, Medicine, Hardware, Stationery, Custom)
  - Price (₹)
  - Unit (KG/Gram/Litre/etc.)
  - Base Quantity
  - Is Favorite (boolean)
  - Created Date
  - Last Used Date

Features:
  ✅ Add Product (FAB button, bottom sheet form)
  ✅ Edit Product (tap → edit mode)
  ✅ Delete Product (swipe-to-delete with confirmation)
  ✅ Search Products (instant, live filter as typing)
  ✅ Sort Options: Name (A-Z), Recently Used, Price (High-Low), Category
  ✅ Pin/Unpin Favorite (star icon toggle)
  ✅ Filter by Category (chip filter row at top)

List Item UI:
  - Category color dot/icon (left)
  - Product name (bold)
  - Price + unit (subtitle): "₹80/KG"
  - Favorite star icon (right, tap to toggle)
  - Tap product → Opens Price→Weight calculator pre-filled

Empty State:
  "No products yet. Add your first product to save time!"
```

### 4.8 Favorites

```yaml
Behavior:
  - Shows only products marked as favorite
  - Same list UI as Product Library (filtered view)
  - Displayed as horizontal quick-access row on Home Screen
  - Also accessible as dedicated screen from Home Screen

Quick Calculation:
  - Tap favorite → directly opens calculator with price/unit pre-filled
  - User only needs to enter customer amount → instant result
```

### 4.9 History

```yaml
Auto-Save Behavior:
  - EVERY calculation (Price→Weight, Weight→Price) is auto-saved
  - No manual action needed (frictionless)

History Item Fields:
  - Product Name (if provided, else "Quick Calculation")
  - Calculation Type (Price→Weight / Weight→Price)
  - Input Amount
  - Result
  - Date & Time
  - Category (if linked to a saved product)

Features:
  ✅ Chronological list (newest first)
  ✅ Grouped by Date (Today, Yesterday, This Week, Older)
  ✅ Search history (by product name)
  ✅ Delete individual entry (swipe)
  ✅ Clear All (with confirmation dialog)
  ✅ Sort: Newest first / Oldest first

List Item UI:
  - Product name / "Quick Calc" (bold)
  - Result summary: "₹35 → 437.5g" 
  - Timestamp (relative: "2 min ago", "Yesterday 5:30 PM")
  - Tap → Re-open calculation in calculator (re-editable)

Empty State:
  "No calculations yet. Start calculating to build history!"
```

### 4.10 Shop Profile

```yaml
Fields:
  - Shop Name
  - Owner Name
  - Default Currency (₹ default, extensible)
  - Default Weight Unit (KG default)
  - (Optional) Shop Logo/Icon (local image picker)

Usage:
  - Shop Name shown on Home Screen header
  - Default unit pre-selected in all calculators
  - Purely local, no cloud sync (V1 scope)
```

### 4.11 Settings

```yaml
Sections:
  1. Appearance:
     - Theme: Dark / Light / System (radio/segmented control)
  
  2. Language:
     - English / Hindi (segmented control)
     - (Uses Flutter intl / easy_localization)
  
  3. Defaults:
     - Default Currency Symbol
     - Default Weight Unit
  
  4. History:
     - Auto-save toggle (default: ON)
     - Clear All History (button, confirmation required)
  
  5. About:
     - App Version
     - Reset Application (clears ALL local data, confirmation required)
     - Rate App (Play Store link)
     - Share App

UI: Grouped list (iOS Settings app style), each section in a card
```

---

## 5. CORE CALCULATION ENGINE (Formulas)

### 5.1 Unit Conversion Table

```yaml
Base Conversions (to smallest unit):
  Weight:
    KG → Gram: × 1000
    Gram → Gram: × 1
  
  Volume:
    Litre → ML: × 1000
    ML → ML: × 1
  
  Count:
    Dozen → Piece: × 12
    Piece → Piece: × 1
  
  Length:
    Meter → Feet: × 3.28084
    Feet → Feet: × 1
  
  Container (treated as whole units):
    Packet, Bottle, Bag → × 1 (no sub-division)

Implementation Strategy:
  - Convert everything to smallest common unit internally
  - Perform calculation
  - Convert back to display unit
```

### 5.2 Price → Weight Formula (Complete Dart Code)

```dart
// core/utils/calculation_engine.dart

class CalculationEngine {
  
  /// Calculate weight from price
  /// Example: Price=80 (per 1 KG), CustomerAmount=35 → Returns 437.5 (grams)
  static double calculatePriceToWeight({
    required double productPrice,      // e.g., 80
    required double baseQuantity,      // e.g., 1 (KG)
    required double customerAmount,    // e.g., 35
  }) {
    if (productPrice <= 0 || baseQuantity <= 0) return 0;
    
    // Price per unit (smallest unit, e.g., per gram)
    final pricePerUnit = productPrice / baseQuantity;
    
    // Result quantity
    final resultQuantity = customerAmount / pricePerUnit;
    
    return resultQuantity;
  }
  
  /// Calculate price from weight
  /// Example: Price=80/KG, CustomerWeight=750g → Returns 60 (₹)
  static double calculateWeightToPrice({
    required double productPrice,      // e.g., 80
    required double baseQuantity,      // e.g., 1 (KG)
    required double customerQuantity,  // e.g., 0.75 (KG) or converted
  }) {
    if (baseQuantity <= 0) return 0;
    
    final pricePerUnit = productPrice / baseQuantity;
    final resultPrice = pricePerUnit * customerQuantity;
    
    return resultPrice;
  }
  
  /// Profit Calculator
  static ProfitResult calculateProfit({
    required double costPrice,
    required double sellingPrice,
  }) {
    final profit = sellingPrice - costPrice;
    final profitPercent = costPrice > 0 ? (profit / costPrice) * 100 : 0;
    final marginPercent = sellingPrice > 0 ? (profit / sellingPrice) * 100 : 0;
    
    return ProfitResult(
      profitAmount: profit,
      profitPercent: profitPercent.toDouble(),
      marginPercent: marginPercent.toDouble(),
      isProfit: profit >= 0,
    );
  }
  
  /// Discount Calculator
  static DiscountResult calculateDiscount({
    required double originalPrice,
    required double discountPercent,
  }) {
    final discountAmount = originalPrice * (discountPercent / 100);
    final finalPrice = originalPrice - discountAmount;
    
    return DiscountResult(
      discountAmount: discountAmount,
      finalPrice: finalPrice,
      savings: discountAmount,
    );
  }
  
  /// GST Calculator (Add Mode)
  static GSTResult calculateGSTAdd({
    required double amount,
    required double gstPercent,
  }) {
    final gstValue = amount * (gstPercent / 100);
    final finalAmount = amount + gstValue;
    
    return GSTResult(
      gstValue: gstValue,
      finalAmount: finalAmount,
      baseAmount: amount,
    );
  }
  
  /// GST Calculator (Remove Mode - reverse from inclusive amount)
  static GSTResult calculateGSTRemove({
    required double inclusiveAmount,
    required double gstPercent,
  }) {
    final baseAmount = inclusiveAmount / (1 + gstPercent / 100);
    final gstValue = inclusiveAmount - baseAmount;
    
    return GSTResult(
      gstValue: gstValue,
      finalAmount: inclusiveAmount,
      baseAmount: baseAmount,
    );
  }
  
  /// Convert quantity between units (same category)
  static double convertUnit({
    required double value,
    required String fromUnit,
    required String toUnit,
  }) {
    final baseValue = _toBaseUnit(value, fromUnit);
    return _fromBaseUnit(baseValue, toUnit);
  }
  
  static double _toBaseUnit(double value, String unit) {
    switch (unit) {
      case 'KG': return value * 1000;
      case 'Gram': return value;
      case 'Litre': return value * 1000;
      case 'ML': return value;
      case 'Dozen': return value * 12;
      case 'Piece': return value;
      case 'Meter': return value * 100;
      case 'Feet': return value * 30.48;
      default: return value;
    }
  }
  
  static double _fromBaseUnit(double baseValue, String unit) {
    switch (unit) {
      case 'KG': return baseValue / 1000;
      case 'Gram': return baseValue;
      case 'Litre': return baseValue / 1000;
      case 'ML': return baseValue;
      case 'Dozen': return baseValue / 12;
      case 'Piece': return baseValue;
      case 'Meter': return baseValue / 100;
      case 'Feet': return baseValue / 30.48;
      default: return baseValue;
    }
  }
}

class ProfitResult {
  final double profitAmount;
  final double profitPercent;
  final double marginPercent;
  final bool isProfit;
  
  ProfitResult({
    required this.profitAmount,
    required this.profitPercent,
    required this.marginPercent,
    required this.isProfit,
  });
}

class DiscountResult {
  final double discountAmount;
  final double finalPrice;
  final double savings;
  
  DiscountResult({
    required this.discountAmount,
    required this.finalPrice,
    required this.savings,
  });
}

class GSTResult {
  final double gstValue;
  final double finalAmount;
  final double baseAmount;
  
  GSTResult({
    required this.gstValue,
    required this.finalAmount,
    required this.baseAmount,
  });
}
```

### 5.3 Smart Number Formatting

```dart
// core/utils/number_formatter.dart

class NumberFormatter {
  
  /// Smart rounding for shop-friendly display
  /// e.g., 437.5 grams → also show 438 (rounded)
  static String formatResult(double value, String unit) {
    if (unit == 'Gram' || unit == 'ML') {
      return value.toStringAsFixed(1); // 437.5
    } else if (unit == 'KG' || unit == 'Litre') {
      return value.toStringAsFixed(3); // 0.438
    } else {
      return value.toStringAsFixed(2); // ₹ amounts
    }
  }
  
  static int roundedValue(double value) {
    return value.round();
  }
  
  /// Currency formatting: ₹35.00, ₹1,234.50
  static String formatCurrency(double value) {
    return '₹${value.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }
}
```

---

## 6. LOCAL DATABASE SCHEMA (Isar)

### 6.1 Product Collection

```dart
// data/models/product_model.dart

import 'package:isar/isar.dart';

part 'product_model.g.dart';

@collection
class ProductModel {
  Id id = Isar.autoIncrement;
  
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;
  
  @Index()
  late String category;
  
  late double price;
  
  late String unit;
  
  late double baseQuantity;
  
  @Index()
  bool isFavorite = false;
  
  late DateTime createdAt;
  
  DateTime? lastUsedAt;
  
  int useCount = 0;
}
```

### 6.2 History Collection

```dart
// data/models/history_model.dart

import 'package:isar/isar.dart';

part 'history_model.g.dart';

@collection
class HistoryModel {
  Id id = Isar.autoIncrement;
  
  String? productName;
  
  late String calculationType; // 'price_to_weight' | 'weight_to_price'
  
  late double inputPrice;
  late double inputQuantity;
  late String unit;
  
  late double inputAmount;
  late double resultValue;
  
  @Index()
  late DateTime timestamp;
  
  int? linkedProductId;
}
```

### 6.3 Shop Profile Collection

```dart
// data/models/shop_profile_model.dart

import 'package:isar/isar.dart';

part 'shop_profile_model.g.dart';

@collection
class ShopProfileModel {
  Id id = Isar.autoIncrement;
  
  String shopName = '';
  String ownerName = '';
  String defaultCurrency = '₹';
  String defaultWeightUnit = 'KG';
  String? logoPath;
}
```

### 6.4 Settings Collection

```dart
// data/models/settings_model.dart

import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement;
  
  String themeMode = 'system';
  String language = 'en';
  bool autoSaveHistory = true;
}
```

### 6.5 Database Initialization

```dart
// core/database/isar_service.dart

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar isar;
  
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    
    isar = await Isar.open(
      [
        ProductModelSchema,
        HistoryModelSchema,
        ShopProfileModelSchema,
        SettingsModelSchema,
      ],
      directory: dir.path,
      name: 'dukandar_db',
    );
    
    print('✅ Isar database initialized at: ${dir.path}');
  }
}
```

---

## 7. STATE MANAGEMENT (Riverpod)

### 7.1 Calculator Provider (Price → Weight)

```dart
// presentation/providers/calculator_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calculator_provider.g.dart';

class PriceToWeightState {
  final String productName;
  final double price;
  final String unit;
  final double baseQuantity;
  final double customerAmount;
  final double result;
  
  PriceToWeightState({
    this.productName = '',
    this.price = 0,
    this.unit = 'KG',
    this.baseQuantity = 1,
    this.customerAmount = 0,
    this.result = 0,
  });
  
  PriceToWeightState copyWith({
    String? productName,
    double? price,
    String? unit,
    double? baseQuantity,
    double? customerAmount,
    double? result,
  }) {
    return PriceToWeightState(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      customerAmount: customerAmount ?? this.customerAmount,
      result: result ?? this.result,
    );
  }
}

@riverpod
class PriceToWeightCalculator extends _$PriceToWeightCalculator {
  @override
  PriceToWeightState build() {
    return PriceToWeightState();
  }
  
  void updatePrice(double price) {
    state = state.copyWith(price: price);
    _recalculate();
  }
  
  void updateUnit(String unit) {
    state = state.copyWith(unit: unit);
    _recalculate();
  }
  
  void updateBaseQuantity(double qty) {
    state = state.copyWith(baseQuantity: qty);
    _recalculate();
  }
  
  void updateCustomerAmount(double amount) {
    state = state.copyWith(customerAmount: amount);
    _recalculate();
  }
  
  void updateProductName(String name) {
    state = state.copyWith(productName: name);
  }
  
  void prefillFromProduct(ProductModel product) {
    state = PriceToWeightState(
      productName: product.name,
      price: product.price,
      unit: product.unit,
      baseQuantity: product.baseQuantity,
    );
  }
  
  void _recalculate() {
    final result = CalculationEngine.calculatePriceToWeight(
      productPrice: state.price,
      baseQuantity: state.baseQuantity,
      customerAmount: state.customerAmount,
    );
    
    state = state.copyWith(result: result);
  }
  
  void reset() {
    state = PriceToWeightState();
  }
}
```

### 7.2 Product Provider

```dart
// presentation/providers/product_provider.dart

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<ProductModel>> build() async {
    return _fetchAll();
  }
  
  Future<List<ProductModel>> _fetchAll() async {
    return await IsarService.isar.productModels
        .where()
        .sortByLastUsedAtDesc()
        .findAll();
  }
  
  Future<void> addProduct(ProductModel product) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.put(product);
    });
    ref.invalidateSelf();
  }
  
  Future<void> updateProduct(ProductModel product) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.put(product);
    });
    ref.invalidateSelf();
  }
  
  Future<void> deleteProduct(int id) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.productModels.delete(id);
    });
    ref.invalidateSelf();
  }
  
  Future<void> toggleFavorite(int id) async {
    final product = await IsarService.isar.productModels.get(id);
    if (product != null) {
      product.isFavorite = !product.isFavorite;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.productModels.put(product);
      });
      ref.invalidateSelf();
    }
  }
  
  Future<List<ProductModel>> search(String query) async {
    if (query.isEmpty) return _fetchAll();
    
    return await IsarService.isar.productModels
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }
}

@riverpod
Future<List<ProductModel>> favoriteProducts(FavoriteProductsRef ref) async {
  return await IsarService.isar.productModels
      .filter()
      .isFavoriteEqualTo(true)
      .sortByLastUsedAtDesc()
      .findAll();
}
```

### 7.3 History Provider

```dart
// presentation/providers/history_provider.dart

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryModel>> build() async {
    return await IsarService.isar.historyModels
        .where()
        .sortByTimestampDesc()
        .findAll();
  }
  
  Future<void> addHistoryEntry(HistoryModel entry) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.put(entry);
    });
    ref.invalidateSelf();
  }
  
  Future<void> deleteEntry(int id) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.delete(id);
    });
    ref.invalidateSelf();
  }
  
  Future<void> clearAll() async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.historyModels.clear();
    });
    ref.invalidateSelf();
  }
}
```

---

## 8. SCREEN-BY-SCREEN UI SPECIFICATIONS

### 8.1 Price → Weight Screen (Complete Widget Code)

```dart
// presentation/screens/price_to_weight/price_to_weight_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PriceToWeightScreen extends ConsumerWidget {
  const PriceToWeightScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(priceToWeightCalculatorProvider);
    final notifier = ref.read(priceToWeightCalculatorProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price → Weight'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            onPressed: () => _saveAsProduct(context, ref, state),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductAutocompleteField(
              value: state.productName,
              onChanged: notifier.updateProductName,
              onProductSelected: notifier.prefillFromProduct,
            ),
            
            const SizedBox(height: 16),
            
            PremiumTextField(
              label: 'Product Price',
              prefix: '₹',
              keyboardType: TextInputType.number,
              onChanged: (val) => notifier.updatePrice(double.tryParse(val) ?? 0),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: UnitSelector(
                    selected: state.unit,
                    onChanged: notifier.updateUnit,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PremiumTextField(
                    label: 'Base Qty',
                    initialValue: state.baseQuantity.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => notifier.updateBaseQuantity(double.tryParse(val) ?? 1),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            PremiumTextField(
              label: 'Customer Amount',
              prefix: '₹',
              keyboardType: TextInputType.number,
              autofocus: true,
              onChanged: (val) => notifier.updateCustomerAmount(double.tryParse(val) ?? 0),
            ),
            
            const SizedBox(height: 32),
            
            ResultCard(
              value: state.result,
              unit: state.unit,
              formula: '₹${state.price} ÷ ${state.baseQuantity}${state.unit} '
                  '= ₹${(state.price / state.baseQuantity).toStringAsFixed(3)} per ${state.unit}\n'
                  '₹${state.customerAmount} ÷ price/unit = ${state.result.toStringAsFixed(1)} ${state.unit}',
            ).animate()
              .fadeIn(duration: 400.ms)
              .scale(begin: const Offset(0.95, 0.95), duration: 400.ms),
          ],
        ),
      ),
    );
  }
  
  void _saveAsProduct(BuildContext context, WidgetRef ref, PriceToWeightState state) {
    if (state.productName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a product name first')),
      );
      return;
    }
    
    final product = ProductModel()
      ..name = state.productName
      ..price = state.price
      ..unit = state.unit
      ..baseQuantity = state.baseQuantity
      ..category = 'Custom'
      ..createdAt = DateTime.now();
    
    ref.read(productListProvider.notifier).addProduct(product);
    
    HapticFeedback.mediumImpact();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Product saved!')),
    );
  }
}
```

### 8.2 Result Card Widget (Premium, Animated)

```dart
// presentation/widgets/common/result_display.dart

class ResultCard extends StatelessWidget {
  final double value;
  final String unit;
  final String formula;
  
  const ResultCard({
    super.key,
    required this.value,
    required this.unit,
    required this.formula,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer should receive',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return Text(
                '${animatedValue.toStringAsFixed(1)} $unit',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 42,
                ),
              );
            },
          ),
          
          const SizedBox(height: 4),
          Text(
            '≈ ${value.round()} $unit (rounded)',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 12),
          
          Text(
            formula,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
```

### 8.3 Unit Selector Widget

```dart
// presentation/widgets/common/unit_selector.dart

class UnitSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  
  static const units = [
    'KG', 'Gram', 'Litre', 'ML', 'Piece',
    'Dozen', 'Meter', 'Feet', 'Packet', 'Bottle', 'Bag',
  ];
  
  const UnitSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUnitPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selected, style: Theme.of(context).textTheme.bodyLarge),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  
  void _showUnitPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: units.map((unit) {
              return ListTile(
                title: Text(unit),
                trailing: selected == unit ? const Icon(Icons.check) : null,
                onTap: () {
                  onChanged(unit);
                  Navigator.pop(context);
                  HapticFeedback.selectionClick();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
```

---

## 9. ANIMATIONS & MICRO-INTERACTIONS

```yaml
Home Screen Card Grid:
  - Stagger fade-in on load (each card delay +50ms)
  - Scale-down on tap (0.97), spring back on release

Result Card:
  - Number counter animation (TweenAnimationBuilder, 300ms)
  - Fade + scale entrance on first calculation
  - Subtle pulse when value changes significantly

Bottom Sheets (Unit Picker, Add Product):
  - Slide up from bottom (300ms, easeOutCubic)
  - Backdrop fade-in simultaneously
  - Drag-to-dismiss gesture support

List Items (Product Library, History):
  - Swipe-to-delete: red background reveal + trash icon
  - Item removal: slide-out + height collapse animation
  - New item added: slide-in from top + fade

Favorite Toggle:
  - Star icon: scale bounce (1.0 → 1.3 → 1.0) + color fill animation
  - Haptic: light impact

Theme Switch (Dark/Light):
  - Crossfade transition (400ms) across entire screen
  - No jarring flash
```

---

## 10. SECURITY & PERFORMANCE

```yaml
Security:
  ✅ All data stored locally (Isar encrypted storage option available)
  ✅ No internet permission requested (AndroidManifest.xml)
  ✅ No unnecessary permissions (camera, contacts, location — NONE needed)
  ✅ No analytics/tracking SDKs in V1 (privacy-first)

Performance Targets:
  ✅ App cold start: < 1.5 seconds
  ✅ Calculation update: < 16ms (60 FPS, no jank)
  ✅ Isar query (search/sort): < 50ms for up to 10,000 products
  ✅ App size: < 20 MB
  ✅ Memory usage: < 100 MB during normal use

Optimization Techniques:
  ✅ Isar indexes on name, category, isFavorite, timestamp
  ✅ Debounce NOT needed for math (pure sync calculation)
  ✅ Debounce autocomplete search (150ms) to reduce query calls
  ✅ Lazy load history list (pagination if > 500 entries)
  ✅ Const widgets wherever possible (reduce rebuilds)
```

---

## 11. VERSION 1 SCOPE (STRICT BOUNDARIES)

```yaml
✅ INCLUDED IN V1:
  1. Price → Weight Calculator
  2. Weight → Price Calculator
  3. Profit Calculator
  4. Discount Calculator
  5. GST Calculator
  6. Product Library (Add/Edit/Delete/Search/Sort)
  7. Favorites
  8. History (auto-save, search, delete, clear)
  9. Shop Profile
  10. Settings (Theme, Language, Defaults)
  11. Premium Apple-inspired UI (Dark + Light)
  12. 100% Offline (Isar local database)
  13. Smooth animations (60 FPS)
  14. Haptic feedback

❌ EXPLICITLY EXCLUDED FROM V1 (Future Versions):
  1. AI Assistant
  2. Voice Commands
  3. Barcode Scanner
  4. OCR (receipt/label scanning)
  5. Cloud Sync
  6. Login System
  7. Stock Management
  8. Customer Ledger
  9. Invoice Generator

Rationale:
  V1 must PROVE the core value proposition (instant price↔weight
  calculation) with a flawless, premium, offline experience before
  adding complexity. Feature creep in V1 = delayed launch + diluted focus.
```

---

## 12. BUILD & DEPLOYMENT GUIDE

```yaml
Step 1: Project Setup
  flutter create dukandar --platforms=android
  cd dukandar
  
Step 2: Add Dependencies (pubspec.yaml)
  flutter pub add flutter_riverpod riverpod_annotation
  flutter pub add isar isar_flutter_libs path_provider
  flutter pub add go_router flutter_animate google_fonts
  flutter pub add --dev riverpod_generator build_runner isar_generator

Step 3: Generate Code
  dart run build_runner build --delete-conflicting-outputs

Step 4: App Icon & Splash
  flutter pub add flutter_launcher_icons flutter_native_splash
  flutter pub run flutter_launcher_icons
  flutter pub run flutter_native_splash:create

Step 5: Build Release AAB
  flutter build appbundle --release

Step 6: Play Store Checklist
  ✅ App icon (adaptive, dark-theme friendly)
  ✅ Feature graphic
  ✅ Screenshots (5-8, showing key calculators)
  ✅ Privacy Policy (required even for offline apps if any data collected)
  ✅ App description (Hindi + English)
  ✅ Content rating questionnaire
  ✅ Target API level compliance
```

---

## 🔥 FINAL SUMMARY

**App:** Dukandar — Premium Business Calculator  
**Core Value:** Instant Price ↔ Weight calculation for shopkeepers  
**Tech:** Flutter + Riverpod + Isar (100% offline)  
**Design:** Apple-inspired glassmorphism, Dark + Light theme  
**Scope:** 10 core features, strictly no scope creep in V1  

**Implementation Includes:**
- ✅ Complete calculation engine with formulas
- ✅ Full Isar database schema
- ✅ Riverpod state management (live, no-delay updates)
- ✅ Screen-by-screen UI specs with code
- ✅ Complete design system (colors, typography, spacing, animations)
- ✅ Build & deployment guide

**Time Estimate:** 3-4 weeks for full V1 implementation  
**Difficulty:** Medium  
**Impact:** HIGH — solves a real daily pain point for millions of shopkeepers

---

**🎉 BHAI "DUKANDAR" KA COMPLETE PRODUCTION PRD READY HAI!**

**Yeh app India ke har chote dukandar ka "daily business assistant" banega!** 🏪💪✨
