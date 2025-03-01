import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class WithdrawalUseCase implements UseCase<Either, WithdrawalParams> {
  @override
  Future<Either> call({WithdrawalParams? param}) async {
    return await sl<SaveBoxRepository>().withdraw(param!);
  }
}
