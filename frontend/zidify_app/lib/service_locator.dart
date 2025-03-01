import 'package:get_it/get_it.dart';
import 'package:zidify_app/features/user/data_layer/repository/user.dart';
import 'package:zidify_app/features/user/data_layer/source/user_api_service.dart';
import 'package:zidify_app/features/user/domain_layer/bloc/user_bloc.dart';
import 'package:zidify_app/features/user/domain_layer/repository/user.dart';
import 'package:zidify_app/features/user/domain_layer/usecases/get_user.dart';
import 'package:zidify_app/utils/core/network/dio_client.dart';
import 'package:zidify_app/utils/core/network/secure_storage.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Local Storage
  sl.registerSingleton<SecureStorageService>(SecureStorageService());

  // USER FEATURE
  // User API Service
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());

  // User Repository
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  // User Usecases
  sl.registerSingleton<FetchUserUseCase>(FetchUserUseCase());

  // User-Bloc
  sl.registerSingleton<UserBloc>(UserBloc());
}
