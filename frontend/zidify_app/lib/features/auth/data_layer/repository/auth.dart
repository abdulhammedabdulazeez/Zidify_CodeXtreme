import 'package:zidify_app/features/auth/data_layer/models/signin_req_params.dart';
import 'package:zidify_app/features/auth/data_layer/models/signup_req_params.dart';
import 'package:zidify_app/features/auth/data_layer/source/auth_api_service.dart';
import 'package:zidify_app/features/auth/data_layer/source/auth_local_service.dart';
import 'package:zidify_app/features/auth/domain_layer/repository/auth.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    Either result = await sl<AuthApiService>().signup(signupReq);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;

      await sl<SecureStorageService>()
          .saveToken('accessToken', response.data['data']['accessToken']);

      await sl<SecureStorageService>()
          .saveToken('refreshToken', response.data['data']['refreshToken']);

      // Mark the user as a returning user (no longer a first-timer)
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('isFirstTimeUser', false);

      return Right(response);
    });
  }

  @override
  Future<Either> signin(SignInReqParams signinReq) async {
    Either result = await sl<AuthApiService>().signin(signinReq);

    return result.fold((error) {
      // print(error);
      return Left(error);
    }, (data) async {
      Response response = data;

      await sl<SecureStorageService>()
          .saveToken('accessToken', response.data['data']['accessToken']);

      await sl<SecureStorageService>()
          .saveToken('refreshToken', response.data['data']['refreshToken']);

      // Mark the user as a returning user (no longer a first-timer)
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('isFirstTimeUser', false);

      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }
}
