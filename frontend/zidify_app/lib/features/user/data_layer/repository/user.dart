import 'package:zidify_app/features/user/data_layer/models/user_model.dart';
import 'package:zidify_app/features/user/data_layer/source/user_api_service.dart';
import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:zidify_app/features/user/domain_layer/repository/user.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Exception, UserEntity>> getUser() async {
    Either<Exception, Response<dynamic>> result =
        await sl<UserApiService>().getUser();

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;

      await sl<SecureStorageService>()
          .saveUserId('userId', response.data['data']['id']);

      var userModel = UserModel.fromJson(response.data['data']);
      var userEntity = userModel.toEntity();
      return Right(userEntity);
    });
  }
}
