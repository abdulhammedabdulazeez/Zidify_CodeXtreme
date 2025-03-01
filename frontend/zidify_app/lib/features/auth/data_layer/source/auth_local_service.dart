import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';
import 'package:dartz/dartz.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    var token = await sl<SecureStorageService>().readToken('accessToken');

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Either> logout() async {
    await sl<SecureStorageService>().deleteAllTokens();

    return const Right(true);
  }
}
