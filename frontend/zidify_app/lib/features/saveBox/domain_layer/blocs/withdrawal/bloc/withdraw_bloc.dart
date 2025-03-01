import 'dart:async';

import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class SaveBoxWithdrawalBloc
    extends Bloc<SaveBoxWithdrawalEvent, SaveBoxWithdrawalState> {
  SaveBoxWithdrawalBloc() : super(WithdrawalInitialState()) {
    on<OnSelectWithdrawalOptionEvent>(_onSelectWithdrawalOptionEvent);
    on<OnHighlightListOptionEvent>(_onHighlightListOptionEvent);
    on<OnResetWithdrawalSelectionEvent>(_onResetWithdrawalSelectionEvent);
  }

  FutureOr<void> _onSelectWithdrawalOptionEvent(
      OnSelectWithdrawalOptionEvent event,
      Emitter<SaveBoxWithdrawalState> emit) {
    FundDestination highlightedItem = state is WithdrawalOptionSelectedState
        ? (state as WithdrawalOptionSelectedState).highlightedItem
        : FundDestination(
            destinationId: "",
            userId: "",
            type: "",
            accountNumber: "",
            accountName: "",
            momoName: "",
            momoNumber: "",
          );

    emit(WithdrawalOptionSelectedState(
      activeWithdrawalType: event.withdrawalOption.type,
      highlightedItem: highlightedItem,
      // highlightedItem: highlightedItem,
    ));
    print(highlightedItem.accountNumber);
  }

  FutureOr<void> _onHighlightListOptionEvent(
      OnHighlightListOptionEvent event, Emitter<SaveBoxWithdrawalState> emit) {
    if (state is WithdrawalOptionSelectedState) {
      final currentState = state as WithdrawalOptionSelectedState;

      // Update the highlighted item for the specific deposit name
      final updatedItem = currentState.highlightedItem.copyWith(
        destinationId: event.selectedOption.destinationId,
        userId: event.selectedOption.userId,
        type: event.selectedOption.type,
        accountNumber: event.selectedOption.accountNumber,
        accountName: event.selectedOption.accountName,
        momoName: event.selectedOption.momoName,
        momoNumber: event.selectedOption.momoNumber,
      );

      print("updatedItems: ${updatedItem.accountNumber}");
      emit(currentState.copyWith(highlightedItem: updatedItem));
    }
  }

  FutureOr<void> _onResetWithdrawalSelectionEvent(
      OnResetWithdrawalSelectionEvent event,
      Emitter<SaveBoxWithdrawalState> emit) {
    emit(WithdrawalInitialState());
  }
}
