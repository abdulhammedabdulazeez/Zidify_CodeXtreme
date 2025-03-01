import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/savebox_model.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/source/savebox_api_service.dart';
import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SaveBoxRepositoryImpl implements SaveBoxRepository {
  @override
  Future<Either<Exception, SaveboxEntity>> getUserSaveBox() async {
    Either<Exception, Response<dynamic>> result =
        await sl<SaveboxApiService>().getUserSaveBox();

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;

      await sl<SecureStorageService>()
          .saveUserId('saveBoxId', response.data['data']['id']);

      var saveBoxModel = SaveboxModel.fromJson(response.data['data']);
      var saveBoxEntity = saveBoxModel.toEntity();
      return Right(saveBoxEntity);
    });
  }

  @override
  Future<Either<Exception, FundingSourceCollection>> getFundingSources() async {
    Either<Exception, Response<dynamic>> result =
        await sl<SaveboxApiService>().getFundingSources();

    return result.fold((error) {
      print('Error: $error');
      return Left(error);
    }, (data) {
      Response response = data;
      var fundingSourceCollection =
          FundingSourceCollection.fromJson(response.data['data']);
      return Right(fundingSourceCollection);
    });
  }

  @override
  Future<Either<Exception, FundDestCollection>> getFundDestinations() async {
    Either<Exception, Response<dynamic>> result =
        await sl<SaveboxApiService>().getFundDestinations();

    return result.fold((error) {
      print('Error: $error');
      return Left(error);
    }, (data) {
      Response response = data;
      var fundDestCollection =
          FundDestCollection.fromJson(response.data['data']);
      return Right(fundDestCollection);
    });
  }

  @override
  Future<Either> deposit(DepositParams depositParams) async {
    Either result = await sl<SaveboxApiService>().deposit(depositParams);

    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      return Right(response);
    });
  }

  @override
  Future<Either> withdraw(WithdrawalParams withdrawalParams) async {
    Either result = await sl<SaveboxApiService>().withdraw(withdrawalParams);

    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      return Right(response);
    });
  }
}
