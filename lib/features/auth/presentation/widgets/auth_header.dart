import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 16.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            size: 36.r,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 24.h),
        Text(_title,
            style: AppTextStyles.headline, textAlign: TextAlign.center),
        SizedBox(height: 8.h),
        Text(
          _subtitle,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
