# Flutter Project Structure

This document describes the organization of a Flutter project following a clean and modular architecture.

---

## Folder Structure

```plaintext
lib/
├── main.dart                   # Application entry point. Calls runApp(AppBootstrap()).
│
├── bootstrap/                  # Initialization and global configuration
│   ├── app_bootstrap.dart      # General app initialization (GetIt, HydratedBloc, global services)
│   ├── app_config.dart         # Configuration for endpoints, clients, global variables
│   └── injection.dart          # Dependency registration by feature and global dependencies
│
├── core/                       # Reusable logic and resources across the app
│   ├── network/
│   │   ├── api_client.dart     # Base client and dependency injection for multiple APIs
│   │   ├── interceptors/
│   ├── error/
│   │   └── failure.dart                # Global error and failure handling
│   │   └── error_translations.dart     # Maps errors to user-friendly messages
│   ├── i18n/
│   │   ├── localization.dart
│   │   └── en.arb / es.arb     # Internationalization and translation files
│   ├── themes/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart      # Defines colors, typography, and global app theme
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── push_service.dart
│   │   └── crashlytics_service.dart # Global services (analytics, notifications, crashlytics, etc.)
│   ├── repositories/
│   │   └── user_repository.dart # Shared data repositories
│   └── utils/
│       ├── validators.dart
│       ├── date_utils.dart
│       └── logger.dart         # General helper functions and utilities
│
├── features/                   # App functionalities, separated by domain
│   ├── auth/
│   │   ├── presentation/bloc/
│   │   ├── presentation/pages/
│   │   ├── data/remote/
│   │   ├── data/models/
│   │   └── domain/
│   └── home/
│       ├── presentation/bloc/
│       ├── presentation/pages/
│       ├── data/remote/
│       ├── data/models/
│       └── domain/
│
├── shared/                     # Reusable components, extensions, and constants
│   ├── widgets/
│   ├── extensions/
│   └── constants/
│
├── data/                       # Local and remote data storage
│   ├── local/
│   └── remote/
│
├── blocs/                      # Optional folder for global or shared BLoCs
│
├── utils/                      # Additional utility functions
│
└── assets/                     # App resources: images, fonts, icons, etc.
```

---

## Notes

- Each **feature** has its own structure: `presentation`, `data`, `domain`.
- `core` contains all reusable logic, including themes, services, utilities, and error handling.
- `bootstrap` centralizes app initialization and dependency injection.
- `shared` holds widgets, extensions, and constants that can be used by any feature.
- `data/local` and `data/remote` separate local persistence logic from API communication.

---