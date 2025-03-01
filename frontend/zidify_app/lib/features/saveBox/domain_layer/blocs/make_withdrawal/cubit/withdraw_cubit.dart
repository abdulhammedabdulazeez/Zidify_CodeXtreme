import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/withdrawal.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  WithdrawCubit() : super(WithdrawInitialState());

  Future<void> makeWithdrawal(WithdrawalParams params) async {
    emit(WithdrawLoadingState());
    try {
      final result = await sl<WithdrawalUseCase>().call(param: params);
      result.fold(
        (failure) => emit(WithdrawFailureState(message: failure.toString())),
        (success) => emit(WithdrawSuccessState()),
      );
    } catch (e) {
      emit(WithdrawFailureState(message: e.toString()));
    }
  }

  void resetState() {
    emit(WithdrawInitialState());
  }
}
