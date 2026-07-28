import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_screen/core/constants/app_strings.dart';
import 'package:login_screen/core/theme/app_colors.dart';
import 'package:login_screen/core/theme/app_text_styles.dart';
import 'package:login_screen/core/utils/validators.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_cubit.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_state.dart';
import 'package:login_screen/features/auth/presentation/widgets/custom_button.dart';
import 'package:login_screen/features/auth/presentation/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _emailController,
            label: AppStrings.emailLabel,
            hint: AppStrings.emailHint,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.validateEmail,
          ),
          SizedBox(height: 20.h),
          BlocSelector<LoginCubit, LoginState, bool>(
            selector: (state) => state.obscurePassword,
            builder: (context, obscurePassword) {
              return CustomTextField(
                controller: _passwordController,
                label: AppStrings.passwordLabel,
                hint: AppStrings.passwordHint,
                obscureText: obscurePassword,
                textInputAction: TextInputAction.done,
                validator: Validators.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed:
                      context.read<LoginCubit>().togglePasswordVisibility,
                ),
              );
            },
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.forgotPassword,
                style: AppTextStyles.link,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return CustomButton(
                text: AppStrings.loginButton,
                isLoading: state is LoginLoading,
                onPressed: _onLoginPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
