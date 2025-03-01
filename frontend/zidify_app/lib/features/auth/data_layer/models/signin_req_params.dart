// To parse this JSON data, do
//
//     final signInReqParams = signInReqParamsFromJson(jsonString);

import 'dart:convert';

SignInReqParams signInReqParamsFromJson(String str) =>
    SignInReqParams.fromJson(json.decode(str));

String signInReqParamsToJson(SignInReqParams data) =>
    json.encode(data.toJson());

class SignInReqParams {
  String email;
  String password;

  SignInReqParams({
    required this.email,
    required this.password,
  });

  factory SignInReqParams.fromJson(Map<String, dynamic> json) =>
      SignInReqParams(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
