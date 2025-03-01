import 'package:zidify_app/features/auth/data_layer/models/signup_req_params.dart';
import 'package:zidify_app/features/auth/domain_layer/repository/auth.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return await sl<AuthRepository>().signup(param!);
  }
}
