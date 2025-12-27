class AppConstants {
  // App Info
  static const String appName = 'Gonana';
  static const String appVersion = '2.0.0';
  static const String appTagline = 'Smart Agricultural Marketplace';

  // API Configuration
  static const String baseUrl = ''; // TODO: Add your backend URL
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String tokenKey = 'token';
  static const String userKey = 'user';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String onboardingKey = 'onboarding_completed';
  static const String registrationStageKey = 'registrationStage';
  static const String bvnSubmissionKey = 'bvnSubmission';

  // Gemini AI Configuration
  static const String geminiApiKey = ''; // TODO: Add from environment
  static const String geminiModel = 'gemini-1.5-flash';
  static const int geminiMaxTokens = 1000;
  static const double geminiTemperature = 0.7;

  // Feature Flags
  static const bool enableAIMatching = true;
  static const bool enableCrypto = true;
  static const bool enableStaking = true;
  static const bool enableSavings = true;

  // Pagination
  static const int pageSize = 15;
  static const int maxImageUpload = 3;

  // Session
  static const Duration sessionTimeout = Duration(minutes: 5);

  // Image
  static const double maxImageSizeMB = 5.0;
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];

  // Nigerian States
  static const List<String> nigerianStates = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
    'FCT'
  ];

  // Product Categories
  static const List<String> productCategories = [
    'Grains & Cereals',
    'Fruits',
    'Vegetables',
    'Livestock',
    'Poultry',
    'Fish & Seafood',
    'Dairy Products',
    'Seeds & Seedlings',
    'Farm Equipment',
    'Fertilizers & Chemicals',
    'Processed Foods',
    'Others',
  ];

  // Currency
  static const String defaultCurrency = 'NGN';
  static const String currencySymbol = '₦';

  // Error Messages
  static const String networkError =
      'No internet connection. Please check your network.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'Something went wrong. Please try again.';
  static const String sessionExpired =
      'Your session has expired. Please login again.';

  // Regex Patterns
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^(\+?234|0)[789]\d{9}$',
  );
  static final RegExp bvnRegex = RegExp(
    r'^\d{11}$',
  );

  // Animation Durations (milliseconds)
  static const int splashDuration = 3000;
  static const int pageTransitionDuration = 300;
  static const int shimmerDuration = 1500;
}
