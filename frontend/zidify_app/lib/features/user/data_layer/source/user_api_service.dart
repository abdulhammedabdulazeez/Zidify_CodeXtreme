import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:zidify_app/utils/core/network/api_url.dart';
import 'package:zidify_app/utils/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserApiService {
  Future<Either<Exception, Response>> getUser();
}

class UserApiServiceImpl implements UserApiService {
  @override
  Future<Either<Exception, Response>> getUser() async {
    try {
      // var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;
      var response = await sl<DioClient>().get(ApiUrls.getUser,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }
}
