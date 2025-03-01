import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class DepositUseCase implements UseCase<Either, DepositParams> {
  @override
  Future<Either> call({DepositParams? param}) async {
    return await sl<SaveBoxRepository>().deposit(param!);
  }
}
