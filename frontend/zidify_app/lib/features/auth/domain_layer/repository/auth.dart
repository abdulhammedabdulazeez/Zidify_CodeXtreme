import 'package:zidify_app/features/auth/data_layer/models/signup_req_params.dart';
import 'package:zidify_app/features/auth/data_layer/models/signin_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SignInReqParams signinReq);
  Future<bool> isLoggedIn();
  Future<Either> logout();
}
