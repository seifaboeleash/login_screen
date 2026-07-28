import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/core/utils/validators.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  /// Toggles password field visibility while preserving the active state type.
  void togglePasswordVisibility() {
    final newObscure = !state.obscurePassword;
    final newState = switch (state) {
      LoginInitial() => LoginInitial(obscurePassword: newObscure),
      LoginLoading() => LoginLoading(obscurePassword: newObscure),
      LoginSuccess() => LoginSuccess(obscurePassword: newObscure),
      LoginFailure(:final errorMessage) => LoginFailure(
          errorMessage: errorMessage,
          obscurePassword: newObscure,
        ),
    };
    emit(newState);
  }

  /// Validates credentials and simulates a login request.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final emailError = Validators.validateEmail(email);
    final passwordError = Validators.validatePassword(password);

    if (emailError != null || passwordError != null) {
      emit(
        LoginFailure(
          errorMessage: emailError ?? passwordError!,
          obscurePassword: state.obscurePassword,
        ),
      );
      return;
    }

    emit(LoginLoading(obscurePassword: state.obscurePassword));

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(LoginSuccess(obscurePassword: state.obscurePassword));
  }

  void resetStatus() {
    emit(LoginInitial(obscurePassword: state.obscurePassword));
  }
}
