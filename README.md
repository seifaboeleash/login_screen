# Flutter Login Screen

A responsive, dark-mode login screen built with Flutter and Clean Architecture principles. This project focuses on the presentation layer with local Cubit state management — no backend or API integration.

## Objective

Build a polished login UI that demonstrates:

- Dark theme with a cohesive color palette and typography
- Form validation for email and password fields
- Simulated async login flow using Cubit
- Responsive layout for mobile and tablet/web viewports
- Clean Architecture folder structure (presentation layer only)

## Folder Structure

```
lib/
├── core/
│   ├── theme/          # AppColors, AppTextStyles, AppTheme
│   └── utils/          # Shared validators
├── features/
│   └── auth/
│       └── presentation/
│           ├── cubit/      # LoginCubit and LoginState
│           ├── pages/      # LoginPage screen
│           └── widgets/    # Reusable auth UI components
└── main.dart               # App entry point
```

| Folder | Purpose |
|--------|---------|
| `core/theme/` | Centralized colors, typography, and `ThemeData` configuration |
| `core/utils/` | Reusable validation logic shared across features |
| `features/auth/presentation/` | Auth UI, state management, and widgets |

## Getting Started

### Prerequisites

- Flutter SDK (3.9+)
- Dart SDK

### Run the app

```bash
flutter pub get
flutter run
```

### Run tests

```bash
flutter test
```

## Screenshots

![Login Screen](screenshots/login.png)

## Architecture Decisions

### Why Cubit?

[Cubit](https://bloclibrary.dev/#/coreconcepts?id=cubit) provides lightweight, predictable state management without the ceremony of full Bloc events. For a UI-only login flow with a few states (loading, success, failure, password visibility), Cubit keeps the code simple while still separating presentation logic from widgets.

### Why this folder structure?

The structure follows **Clean Architecture** conventions:

- **`core/`** holds cross-cutting concerns (theme, validators) used by multiple features
- **`features/auth/presentation/`** isolates the auth UI layer, ready for future `domain/` and `data/` layers when a real backend is added
- **Single responsibility per file** — each widget, cubit, and theme file has one clear job

This layout scales naturally: adding a repository or use case later means creating `domain/` and `data/` folders under `features/auth/` without restructuring the presentation layer.

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | Cubit state management |
| `equatable` | Value equality for state classes |
| `google_fonts` | Inter font for typography |

## License

This project is for demonstration purposes.
