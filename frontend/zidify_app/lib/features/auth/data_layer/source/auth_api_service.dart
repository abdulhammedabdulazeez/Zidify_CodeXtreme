import 'package:zidify_app/features/auth/data_layer/models/signin_req_params.dart';
import 'package:zidify_app/features/auth/data_layer/models/signup_req_params.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/network/api_url.dart';
import 'package:zidify_app/utils/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SignInReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.signup,
        data: signupReq.toJson(),
      );
      // print(response);
      return Right(response);
    } on DioException catch (e) {
      // print('Error Response: ${e.response!.data['data']['message']}');

      return Left(e.response!.data['data']['message']);
    }
  }

  @override
  Future<Either> signin(SignInReqParams signinReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: signinReq.toJson(),
      );
      return Right(response);
    } on DioException catch (e) {
      // print(e.response!.data);
      return Left(e.response!.data['data']['message']);
    }
  }
}
