import 'package:zidify_app/features/auth/domain_layer/repository/auth.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
