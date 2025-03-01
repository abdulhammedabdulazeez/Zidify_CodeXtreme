import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:zidify_app/utils/core/network/api_url.dart';
import 'package:zidify_app/utils/core/network/dio_client.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SaveboxApiService {
  Future<Either<Exception, Response>> getUserSaveBox();
  Future<Either<Exception, Response>> getFundingSources();
  Future<Either<Exception, Response>> getFundDestinations();
  Future<Either> deposit(DepositParams depositParams);
  Future<Either> withdraw(WithdrawalParams withdrawalParams);
}

class SaveboxApiServiceImpl implements SaveboxApiService {
  @override
  Future<Either<Exception, Response>> getUserSaveBox() async {
    try {
      // var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;
      var response = await sl<DioClient>().get(ApiUrls.saveBoxInfo,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }

  @override
  Future<Either<Exception, Response>> getFundingSources() async {
    try {
      // var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;
      var response = await sl<DioClient>().get(ApiUrls.fundingSources,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }

  @override
  Future<Either<Exception, Response>> getFundDestinations() async {
    try {
      // var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;
      var response = await sl<DioClient>().get(ApiUrls.fundDestinations,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }

  @override
  Future<Either> deposit(DepositParams depositParams) async {
    try {
      var id = await sl<SecureStorageService>().readId('saveBoxId');
      //  var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;

      var response = await sl<DioClient>().post(
        ApiUrls.deposit(id!),
        data: depositParams.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }

  @override
  Future<Either> withdraw(WithdrawalParams withdrawalParams) async {
    try {
      var id = await sl<SecureStorageService>().readId('saveBoxId');
      // var token = await sl<SecureStorageService>().readToken('accessToken');
      var token = AppTexts.staticToken;

      var response = await sl<DioClient>().post(
        ApiUrls.withdraw(id!),
        data: withdrawalParams.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(Exception(e.response?.data['data']['message']));
    }
  }
}
