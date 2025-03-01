import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:zidify_app/features/user/domain_layer/repository/user.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchUserUseCase implements UseCase<Either<Exception, UserEntity>, void> {
  @override
  Future<Either<Exception, UserEntity>> call({void param}) async {
    return await sl<UserRepository>().getUser();
  }
}
