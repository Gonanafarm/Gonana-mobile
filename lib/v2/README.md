# Gonana V2 - Clean Architecture Flutter App

## 🏗️ Project Overview
Gonana V2 is a comprehensive agricultural marketplace and financial services platform built with Flutter, following clean architecture principles and modern development practices.

## 📁 Project Structure

```
lib/v2/
├── core/                    # Core functionality
│   ├── config/             # App configuration
│   ├── models/             # Data models
│   ├── network/            # Network layer (Dio)
│   ├── providers/          # Riverpod providers
│   ├── theme/              # App theming
│   └── utils/              # Utilities & helpers
│
├── features/               # Feature modules
│   ├── auth/              # Authentication
│   ├── wallet/            # Wallet & Savings
│   ├── crypto/            # Cryptocurrency
│   ├── marketplace/       # Products & Orders
│   ├── posts/             # Social feed
│   ├── messaging/         # Chat & Messaging
│   ├── referral/          # Referral system
│   └── ...                # Other features
│
└── main_v2.dart           # App entry point
```

## 🎯 Architecture

### Clean Architecture Layers

**Presentation Layer** (`presentation/`)
- Screens (UI)
- Providers (State management with Riverpod)
- Widgets (Reusable components)

**Domain Layer** (Implicit in models)
- Business logic
- Use cases
- Entities

**Data Layer** (`data/`)
- Repositories (API calls)
- Data sources
- DTOs

### State Management
- **Riverpod** for reactive state
- **FutureProvider** for async data
- **StateNotifier** for complex state

## 🔧 Key Technologies

- **Flutter** 3.x
- **Riverpod** 2.6+ (State management)
- **Dio** 5.x (Networking)
- **Dartz** (Functional programming)
- **flutter_animate** (Animations)

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version  # Requires Flutter 3.x
```

### Installation
```bash
# Install dependencies
flutter pub get

# Run app
flutter run
```

### Environment Setup
Update `lib/v2/core/config/api_config.dart`:
```dart
static const Environment currentEnv = Environment.dev; // or production
```

## 📋 Coding Conventions

### Naming
- **Classes**: `PascalCase` (e.g., `WalletRepository`)
- **Files**: `snake_case` (e.g., `wallet_repository.dart`)
- **Variables**: `camelCase` (e.g., `userBalance`)
- **Constants**: `camelCase` (e.g., `primaryColor`)

### Folder Structure per Feature
```
feature_name/
├── data/
│   └── repositories/       # API calls
├── domain/                 # Business logic (if needed)
└── presentation/
    ├── pages/             # Screens
    ├── providers/         # State management
    └── widgets/           # Reusable components
```

### Provider Pattern
```dart
// 1. Define provider
final dataProvider = FutureProvider<Data>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return await repository.getData();
});

// 2. Use in widget
final dataAsync = ref.watch(dataProvider);

// 3. Handle states
dataAsync.when(
  data: (data) => ShowData(data),
  loading: () => LoadingIndicator(),
  error: (error, stack) => ErrorWidget(error),
)
```

## 🎨 UI Guidelines

### Theme
- Use `AppTheme` constants for colors
- Use `AppSpacing` for consistent padding
- Follow Material Design 3 principles

### Widgets
- Keep widgets small and focused
- Extract reusable components
- Use `const` where possible for performance

## 🔐 Security

- JWT tokens stored in SharedPreferences
- Automatic token refresh on 401
- Sensitive data never logged in production

## 📖 Additional Documentation

- **API Integration**: See `backend_integration_guide.md`
- **Provider Wiring**: See `provider_wiring_guide.md`
- **Feature List**: See `walkthrough.md`

## 👥 Contributing

1. Create feature branch
2. Follow coding conventions
3. Add tests
4. Submit PR

## 📄 License

Proprietary - Gonana Inc.
