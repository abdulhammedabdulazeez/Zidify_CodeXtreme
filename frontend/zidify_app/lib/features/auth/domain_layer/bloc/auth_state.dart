part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Signup States
final class SignupLoadingState extends AuthState {}

final class SignupSucessState extends AuthState {}

final class SignupFailureState extends AuthState {
  final String error;

  SignupFailureState({required this.error});
}

// Signin States
final class SigninLoadingState extends AuthState {}

final class SigninSucessState extends AuthState {}

final class SigninFailureState extends AuthState {
  final String error;

  SigninFailureState({required this.error});
}

final class SignupNavigateToLoginActionState extends AuthState {}
