import 'package:flutter/material.dart';
import 'package:login_screen/core/theme/app_colors.dart';
import 'package:login_screen/core/theme/app_text_styles.dart';

/// Header section displayed at the top of auth screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  static const String _title = 'Welcome Back';
  static const String _subtitle = 'Sign in to continue to your account';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_outline_rounded,
            size: 36,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Text(_title,
            style: AppTextStyles.headline, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          _subtitle,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
