# Flutter Login Screen

A responsive, dark-mode login screen built with Flutter, following Clean Architecture principles and Cubit for state management.

## Objective

Build a responsive Flutter screen based on a self-designed UI, demonstrating clean folder structure, reusable widgets, and solid state management practices — without relying on any real backend (no API or Firebase integration; the login request is simulated).

## Features

- Dark mode UI with a custom color palette and typography system
- Fully responsive layout (mobile and wider/tablet viewports) using `flutter_screenutil`
- Form validation for email and password fields
- Password visibility toggle
- Loading state feedback on submit
- Success/failure feedback via `SnackBar`

## Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_strings.dart       # Centralized string constants
│   ├── theme/
│   │   ├── app_colors.dart        # Color palette constants
│   │   ├── app_text_styles.dart   # Reusable TextStyle definitions
│   │   └── app_theme.dart         # ThemeData configuration
│   └── utils/
│       └── validators.dart        # Email/password validation logic
├── features/
│   └── auth/
│       └── presentation/
│           ├── cubit/
│           │   ├── login_cubit.dart   # Business logic for the login flow
│           │   └── login_state.dart   # Sealed state classes (Initial, Loading, Success, Failure)
│           ├── pages/
│           │   └── login_page.dart    # Login screen UI
│           └── widgets/
│               ├── auth_header.dart       # Title/subtitle header
│               ├── custom_text_field.dart # Reusable styled text field
│               ├── custom_button.dart     # Reusable loading-aware button
│               ├── login_form.dart        # Form component for input handling
│               └── sign_up_prompt.dart    # Registration prompt link
└── main.dart
```

Each layer has a single responsibility: `core` holds app-wide styling and utilities shared across features, while `features/auth/presentation` isolates everything specific to the login screen. Splitting widgets into small, reusable components (`CustomTextField`, `CustomButton`, `AuthHeader`, `LoginForm`, `SignUpPrompt`) keeps `login_page.dart` focused on layout and composition rather than styling details.

## Architecture Notes

**Why Cubit?**
Even without a real backend, separating the login logic (validation, simulated request, state transitions) from the widget keeps the UI dumb and the logic testable in isolation. Swapping the simulated `Future.delayed` call for a real API/Firebase call later only requires changing `LoginCubit.login()` — the UI stays untouched.

**Why separate state classes instead of a single state + enum?**
`LoginInitial`, `LoginLoading`, `LoginSuccess`, and `LoginFailure` each extend a common `LoginState` base class. This makes invalid states unrepresentable (e.g. you can't have a "success" state that also carries an error message) and reads clearly at the call site with `state is LoginFailure` checks.

**Why flutter_screenutil?**
Rather than manually computing breakpoints with `MediaQuery`, `flutter_screenutil` provides consistent `.w`/`.h`/`.sp` scaling based on a fixed design size, making spacing and font sizes scale predictably across device sizes.

## Getting Started

```bash
flutter pub get
flutter run
```

## Dependencies

- `flutter_bloc` — state management
- `flutter_screenutil` — responsive sizing

## Screenshots

| Mobile |
|--------|
| ![Login Screen](screenshots/login.png) |

## Notes

This task was built as a UI/architecture exercise — there is no real authentication backend. The login button simulates a network request with a short delay and always succeeds if the input passes validation.
