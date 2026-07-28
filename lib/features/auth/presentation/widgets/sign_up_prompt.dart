import 'package:flutter/material.dart';
import 'package:login_screen/core/constants/app_strings.dart';
import 'package:login_screen/core/theme/app_text_styles.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          AppStrings.signUpPrompt,
          style: AppTextStyles.subtitle,
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            AppStrings.signUpAction,
            style: AppTextStyles.link,
          ),
        ),
      ],
    );
  }
}
