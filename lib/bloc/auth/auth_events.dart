sealed class AuthEvents {}

final class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

final class RegisterEvent extends AuthEvents {
  final String name;
  final String email;
  final String password;
  final String comfirmPassword;
  final String phone;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.comfirmPassword,
    required this.phone,
  });
}

final class LogoutEvent extends AuthEvents {}

final class AppStartedEvent extends AuthEvents{}
