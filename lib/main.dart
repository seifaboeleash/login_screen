import 'package:flutter/material.dart';
import 'package:login_screen/core/theme/app_theme.dart';
import 'package:login_screen/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const LoginApp());
}

/// Root widget configuring theme and the initial login route.
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginPage(),
    );
  }
}
