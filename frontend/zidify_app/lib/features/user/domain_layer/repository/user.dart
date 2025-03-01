import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Exception, UserEntity>> getUser();
}
