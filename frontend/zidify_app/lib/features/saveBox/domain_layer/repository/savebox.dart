import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SaveBoxRepository {
  Future<Either<Exception, SaveboxEntity>> getUserSaveBox();
  Future<Either<Exception, FundingSourceCollection>> getFundingSources();
  Future<Either<Exception, FundDestCollection>> getFundDestinations();
  Future<Either> deposit(DepositParams depositParams);
  Future<Either> withdraw(WithdrawalParams withdrawalParams);
}
