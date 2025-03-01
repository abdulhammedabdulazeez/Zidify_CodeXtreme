import 'package:zidify_app/features/auth/domain_layer/repository/auth.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().logout();
  }
}
