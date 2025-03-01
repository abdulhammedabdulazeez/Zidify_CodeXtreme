import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/deposit.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'deposit_state.dart';

class DepositCubit extends Cubit<DepositState> {
  DepositCubit() : super(DepositInitialState());

  Future<void> makeDeposit(DepositParams params) async {
    emit(DepositLoadingState());
    try {
      final result = await sl<DepositUseCase>().call(param: params);
      result.fold(
        (failure) => emit(DepositFailureState(message: failure.toString())),
        (success) => emit(DepositSuccessState()),
      );
    } catch (e) {
      emit(DepositFailureState(message: e.toString()));
    }
  }

  void resetState() {
    emit(DepositInitialState());
  }
}
