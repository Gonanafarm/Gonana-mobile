import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance!;

  late Box<String> _tokenBox;
  late Box<User> _userBox;
  late Box<dynamic> _settingsBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    _instance = StorageService._();
    await _instance!._openBoxes();
  }

  StorageService._();

  Future<void> _openBoxes() async {
    _tokenBox = await Hive.openBox<String>('tokens');
    _userBox = await Hive.openBox<User>('user');
    _settingsBox = await Hive.openBox('settings');
  }

  // ==================== TOKEN ====================

  Future<void> saveToken(String token) async {
    await _tokenBox.put(AppConstants.tokenKey, token);
  }

  String? getToken() {
    return _tokenBox.get(AppConstants.tokenKey);
  }

  Future<void> deleteToken() async {
    await _tokenBox.delete(AppConstants.tokenKey);
  }

  bool get hasToken => getToken() != null;

  // ==================== USER ====================

  Future<void> saveUser(User user) async {
    await _userBox.put(AppConstants.userKey, user);
  }

  User? getUser() {
    return _userBox.get(AppConstants.userKey);
  }

  Future<void> deleteUser() async {
    await _userBox.delete(AppConstants.userKey);
  }

  bool get hasUser => getUser() != null;

  // ==================== SETTINGS ====================

  Future<void> setThemeMode(String mode) async {
    await _settingsBox.put(AppConstants.themeKey, mode);
  }

  String getThemeMode() {
    return _settingsBox.get(AppConstants.themeKey, defaultValue: 'system');
  }

  Future<void> setLanguage(String languageCode) async {
    await _settingsBox.put(AppConstants.languageKey, languageCode);
  }

  String getLanguage() {
    return _settingsBox.get(AppConstants.languageKey, defaultValue: 'en');
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    await _settingsBox.put(AppConstants.onboardingKey, completed);
  }

  bool get isOnboardingCompleted {
    return _settingsBox.get(AppConstants.onboardingKey, defaultValue: false);
  }

  Future<void> setRegistrationStage(int stage) async {
    await _settingsBox.put(AppConstants.registrationStageKey, stage);
  }

  int get registrationStage {
    return _settingsBox.get(AppConstants.registrationStageKey, defaultValue: 1);
  }

  // ==================== MIGRATION FROM OLD APP ====================

  Future<void> migrateFromSharedPreferences() async {
    // This will be called on first launch of V2
    // to migrate data from old SharedPreferences storage
    try {
      final prefs = await SharedPreferences.getInstance();

      // Migrate token
      final oldToken = prefs.getString('token');
      if (oldToken != null && !hasToken) {
        await saveToken(oldToken);
      }

      // Migrate registration stage
      final oldStage = prefs.getInt('registrationStage');
      if (oldStage != null) {
        await setRegistrationStage(oldStage);
      }

      // Migrate onboarding
      final oldOnboarding = prefs.getBool('onboarding_completed');
      if (oldOnboarding != null) {
        await setOnboardingCompleted(oldOnboarding);
      }

      // Mark migration as complete
      await prefs.setBool('migrated_to_v2', true);
    } catch (e) {
      print('Migration error: $e');
    }
  }

  // ==================== CLEAR ALL ====================

  Future<void> clearAll() async {
    await _tokenBox.clear();
    await _userBox.clear();
    await _settingsBox.clear();
  }
}
