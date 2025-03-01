import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deposit_event.dart';
part 'deposit_state.dart';

class SaveBoxDepositBloc
    extends Bloc<SaveBoxDepositEvent, SaveBoxDepositState> {
  SaveBoxDepositBloc() : super(DepositInitialState()) {
    on<OnSelectDepositOptionEvent>(_onSelectDepositOptionEvent);
    on<OnHighlightListOptionEvent>(_onHighlightListOptionEvent);
    on<OnResetDepositSelectionEvent>(_onResetDepositSelectionEvent);
  }

  void _onSelectDepositOptionEvent(
    OnSelectDepositOptionEvent event,
    Emitter<SaveBoxDepositState> emit,
  ) {
    FundingSource highlightedItem = state is DepositOptionSelectedState
        ? (state as DepositOptionSelectedState).highlightedItem
        : FundingSource(
            sourceId: '',
            userId: '',
            type: '',
            momoName: '',
            momoNumber: '',
            cardHolder: '',
            cardNumber: '',
          );

    emit(DepositOptionSelectedState(
      activeDepositType: event.depositOption.type,
      highlightedItem: highlightedItem,
      // highlightedItems: highlightedItems,
    ));
    print(highlightedItem.sourceId);
  }

  void _onHighlightListOptionEvent(
    OnHighlightListOptionEvent event,
    Emitter<SaveBoxDepositState> emit,
  ) {
    if (state is DepositOptionSelectedState) {
      final currentState = state as DepositOptionSelectedState;

      // Update the highlighted item for the specific deposit name
      final updatedItem = currentState.highlightedItem.copyWith(
        sourceId: event.selectedOption.sourceId,
        userId: event.selectedOption.userId,
        type: event.selectedOption.type,
        momoName: event.selectedOption.momoName,
        momoNumber: event.selectedOption.momoNumber,
        cardHolder: event.selectedOption.cardHolder,
        cardNumber: event.selectedOption.cardNumber,
      );

      print("updatedItems: ${updatedItem.accountNumber}");
      emit(currentState.copyWith(highlightedItem: updatedItem));
    }
  }

  void _onResetDepositSelectionEvent(
    OnResetDepositSelectionEvent event,
    Emitter<SaveBoxDepositState> emit,
  ) {
    emit(DepositInitialState());
  }
}
