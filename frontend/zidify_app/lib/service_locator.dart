import 'package:get_it/get_it.dart';
import 'package:zidify_app/features/saveBox/data_layer/repository/savebox.dart';
import 'package:zidify_app/features/saveBox/data_layer/source/savebox_api_service.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/deposit/bloc/deposit_bloc.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/fund_destinations/cubit/fund_destination_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/funding_sources/cubit/funding_sources_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_deposit/cubit/deposit_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_withdrawal/cubit/withdraw_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/saveBox/cubit/save_box_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/withdraw/bloc/withdraw_bloc.dart';
import 'package:zidify_app/features/saveBox/domain_layer/repository/savebox.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/deposit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_fundDestinations.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_fundingSources.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_savebox.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/withdrawal.dart';
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


  // SAVEBOX FEATURE
  // SaveBox API Service
  sl.registerSingleton<SaveboxApiService>(SaveboxApiServiceImpl());

  // SaveBox Repository
  sl.registerSingleton<SaveBoxRepository>(SaveBoxRepositoryImpl());

  // SaveBox Usecases
  sl.registerSingleton<FetchSaveBoxUseCase>(FetchSaveBoxUseCase());
  sl.registerSingleton<FetchFundingSourcesUseCase>(
      FetchFundingSourcesUseCase());
  sl.registerSingleton<FetchFundDestUseCase>(FetchFundDestUseCase());
  sl.registerSingleton<DepositUseCase>(DepositUseCase());
  sl.registerSingleton<WithdrawalUseCase>(WithdrawalUseCase());

  // SaveBox-Cubits || Savebox-Blocs
  sl.registerSingleton(SaveBoxDepositBloc());
  sl.registerSingleton(SaveBoxWithdrawalBloc());
  sl.registerSingleton<SaveBoxCubit>(SaveBoxCubit());
  sl.registerSingleton<FundingSourcesCubit>(FundingSourcesCubit());
  sl.registerSingleton<FundDestinationCubit>(FundDestinationCubit());

  // SaveBox Transacctions
  sl.registerSingleton<DepositCubit>(DepositCubit());
  sl.registerSingleton<WithdrawCubit>(WithdrawCubit());
}
