// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class OnSignupSubmitAuthEvent extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;

  OnSignupSubmitAuthEvent({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
  });
}

class OnLoginButtonClickedAuthEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginButtonClickedAuthEvent({
    required this.email,
    required this.password,
  });
}

class OnSignupWithGoogleButtonClickedAuthEvent extends AuthEvent {}
