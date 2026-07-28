import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_screen/core/constants/app_strings.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_cubit.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_state.dart';
import 'package:login_screen/features/auth/presentation/widgets/auth_header.dart';
import 'package:login_screen/features/auth/presentation/widgets/login_form.dart';
import 'package:login_screen/features/auth/presentation/widgets/sign_up_prompt.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) =>
                  current.runtimeType != previous.runtimeType,
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppStrings.successMessage)),
                  );
                  context.read<LoginCubit>().resetStatus();
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                  context.read<LoginCubit>().resetStatus();
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 420.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthHeader(),
                        SizedBox(height: 40.h),
                        const LoginForm(),
                        SizedBox(height: 32.h),
                        const SignUpPrompt(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
