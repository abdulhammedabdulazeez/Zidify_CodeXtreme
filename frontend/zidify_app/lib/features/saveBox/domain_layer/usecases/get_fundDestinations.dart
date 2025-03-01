import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchFundDestUseCase
    implements UseCase<Either<Exception, FundDestCollection>, void> {
  @override
  Future<Either<Exception, FundDestCollection>> call({void param}) {
    return sl<SaveBoxRepository>().getFundDestinations();
  }
}
