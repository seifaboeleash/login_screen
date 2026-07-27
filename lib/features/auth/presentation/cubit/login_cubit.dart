import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/core/utils/validators.dart';
import 'package:login_screen/features/auth/presentation/cubit/login_state.dart';

/// Manages login form state and simulates an authentication request.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  /// Toggles password field visibility.
  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
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
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: emailError ?? passwordError,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: LoginStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        status: LoginStatus.success,
        clearErrorMessage: true,
      ),
    );
  }

  /// Resets status back to initial after handling side effects (e.g. SnackBar).
  void resetStatus() {
    emit(
      state.copyWith(
        status: LoginStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }
}
