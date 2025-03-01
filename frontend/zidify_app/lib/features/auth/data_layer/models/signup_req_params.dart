// To parse this JSON data, do
//
//     final signUpReqParams = signUpReqParamsFromJson(jsonString);

import 'dart:convert';

SignupReqParams signUpReqParamsFromJson(String str) =>
    SignupReqParams.fromJson(json.decode(str));

String signUpReqParamsToJson(SignupReqParams data) =>
    json.encode(data.toJson());

class SignupReqParams {
  String email;
  String firstName;
  String lastName;
  String password;
  String phoneNumber;

  SignupReqParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
  });

  factory SignupReqParams.fromJson(Map<String, dynamic> json) =>
      SignupReqParams(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "phoneNumber": phoneNumber,
      };
}
