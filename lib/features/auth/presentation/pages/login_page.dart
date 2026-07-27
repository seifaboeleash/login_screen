import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/core/theme/app_colors.dart';
import 'package:login_screen/core/theme/app_text_styles.dart';
import 'package:login_screen/core/utils/validators.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_cubit.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_state.dart';
import 'package:login_screen/features/auth/presentation/widgets/auth_header.dart';
import 'package:login_screen/features/auth/presentation/widgets/custom_button.dart';
import 'package:login_screen/features/auth/presentation/widgets/custom_text_field.dart';

/// The main login screen with responsive layout and form validation.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String _emailLabel = 'Email';
  static const String _emailHint = 'Enter your email';
  static const String _passwordLabel = 'Password';
  static const String _passwordHint = 'Enter your password';
  static const String _forgotPassword = 'Forgot password?';
  static const String _loginButton = 'Sign In';
  static const String _signUpPrompt = "Don't have an account? ";
  static const String _signUpAction = 'Sign up';
  static const String _successMessage = 'Login successful';
  static const double _tabletBreakpoint = 600;
  static const double _formMaxWidth = 420;
  static const double _horizontalPadding = 24;

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
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == LoginStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(_successMessage)),
                );
                context.read<LoginCubit>().resetStatus();
              } else if (state.status == LoginStatus.failure &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
                context.read<LoginCubit>().resetStatus();
              }
            },
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > _tabletBreakpoint;
                  final horizontalPadding = isWide ? 0.0 : _horizontalPadding;

                  return Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 32,
                      ),
                      child: SizedBox(
                        width: isWide ? _formMaxWidth : constraints.maxWidth,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const AuthHeader(),
                              const SizedBox(height: 40),
                              CustomTextField(
                                controller: _emailController,
                                label: _emailLabel,
                                hint: _emailHint,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validateEmail,
                              ),
                              const SizedBox(height: 20),
                              BlocSelector<LoginCubit, LoginState, bool>(
                                selector: (state) => state.obscurePassword,
                                builder: (context, obscurePassword) {
                                  return CustomTextField(
                                    controller: _passwordController,
                                    label: _passwordLabel,
                                    hint: _passwordHint,
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
                                      onPressed: context
                                          .read<LoginCubit>()
                                          .togglePasswordVisibility,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    _forgotPassword,
                                    style: AppTextStyles.link,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                text: _loginButton,
                                isLoading: state.isLoading,
                                onPressed: _onLoginPressed,
                              ),
                              const SizedBox(height: 32),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    _signUpPrompt,
                                    style: AppTextStyles.subtitle,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      _signUpAction,
                                      style: AppTextStyles.link,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
