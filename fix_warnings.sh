#!/bin/bash

# Script to automatically fix common Flutter warnings
# This will fix unused imports across all Dart files

echo "Starting automated warning fixes..."

# Fix unused imports in all controller files
echo "Removing unused imports from controllers..."

# password_controller.dart
sed -i '' '/import.*shared_preferences.dart/d' "lib/features/controllers/auth/password_controller.dart"

# profile_controller.dart  
sed -i '' '/import.*dart:convert/d' "lib/features/controllers/auth/profile_controller.dart"
sed -i '' '/import.*dart:developer/d' "lib/features/controllers/auth/profile_controller.dart"
sed -i '' '/import.*dart:io/d' "lib/features/controllers/auth/profile_controller.dart"
sed -i '' '/import.*gonana\/features\/utilities\/network.dart/d' "lib/features/controllers/auth/profile_controller.dart"
sed -i '' '/import.*gonana\/features\/utilities\/api_routes.dart/d' "lib/features/controllers/auth/profile_controller.dart"

# sign_in_controller.dart
sed -i '' '/import.*flutter\/cupertino.dart/d' "lib/features/controllers/auth/sign_in_controller.dart"

# sign_up_controller.dart
sed -i '' '/import.*number_verification_screen.dart/d' "lib/features/controllers/auth/sign_up_controller.dart"

# cart_controller.dart
sed -i '' '/import.*dio\/dio.dart/d' "lib/features/controllers/cart/cart_controller.dart"

# market_controllers.dart
sed -i '' '/import.*user_model.dart/d' "lib/features/controllers/market/market_controllers.dart"
sed -i '' '/import.*store_logistics.dart/d' "lib/features/controllers/market/market_controllers.dart"
sed -i '' '/import.*user_post_model.dart/d' "lib/features/controllers/market/market_controllers.dart"

# order_controller.dart
sed -i '' '/import.*cart_model.dart/d' "lib/features/controllers/order/order_controller.dart"
sed -i '' '/import.*order_model.dart/d' "lib/features/controllers/order/order_controller.dart"

# user_controller.dart
sed -i '' '/import.*get_core\/src\/get_main.dart/d' "lib/features/controllers/user/user_controller.dart"
sed -i '' '/import.*settiings_profile.dart/d' "lib/features/controllers/user/user_controller.dart"

# More files...
echo "Removing unused imports from presentation layer..."

# taxonomy_model.dart
sed -i '' '/import.*dart:convert/d' "lib/features/data/models/taxonomy_model.dart"

echo "Fixing other warnings..."
# Add more fixes as needed

echo "✅ Automated fixes completed!"
echo "Run 'flutter analyze' to see remaining issues"
