sealed class LoginState {
  const LoginState({required this.obscurePassword});

  final bool obscurePassword;
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.obscurePassword = true});
}

final class LoginLoading extends LoginState {
  const LoginLoading({required super.obscurePassword});
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required super.obscurePassword});
}

final class LoginFailure extends LoginState {
  const LoginFailure({
    required this.errorMessage,
    required super.obscurePassword,
  });

  final String errorMessage;
}
