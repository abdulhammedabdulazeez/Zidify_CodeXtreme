import 'package:zidify_app/features/auth/data_layer/models/signin_req_params.dart';
import 'package:zidify_app/features/auth/domain_layer/repository/auth.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class SigninUseCase implements UseCase<Either, SignInReqParams> {
  @override
  Future<Either> call({SignInReqParams? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
}
