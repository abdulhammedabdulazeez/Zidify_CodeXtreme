import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchFundingSourcesUseCase
    implements UseCase<Either<Exception, FundingSourceCollection>, void> {
  @override
  Future<Either<Exception, FundingSourceCollection>> call({void param}) {
    return sl<SaveBoxRepository>().getFundingSources();
  }
}
