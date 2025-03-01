import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchSaveBoxUseCase
    implements UseCase<Either<Exception, SaveboxEntity>, void> {
  @override
  Future<Either<Exception, SaveboxEntity>> call({void param}) {
    return sl<SaveBoxRepository>().getUserSaveBox();
  }
}
