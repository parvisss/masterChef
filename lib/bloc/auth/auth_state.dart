import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userToken;
  AuthAuthenticated(this.userToken);

  @override
  List<Object?> get props => [userToken];
}

class AuthUnauthenticated extends AuthState {}

final class AuthLogedout extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError({
    required this.message,
  });
}
