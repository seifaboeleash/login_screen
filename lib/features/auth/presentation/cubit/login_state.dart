import 'package:equatable/equatable.dart';

/// Represents the current phase of the login flow.
enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

/// Immutable state for the login screen, combining status and UI flags.
///
/// Uses a single state class with a [LoginStatus] enum rather than multiple
/// state subclasses, keeping password visibility and error messages in one place.
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.obscurePassword = true,
    this.errorMessage,
  });

  final LoginStatus status;
  final bool obscurePassword;
  final String? errorMessage;

  bool get isLoading => status == LoginStatus.loading;

  LoginState copyWith({
    LoginStatus? status,
    bool? obscurePassword,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return LoginState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, obscurePassword, errorMessage];
}
