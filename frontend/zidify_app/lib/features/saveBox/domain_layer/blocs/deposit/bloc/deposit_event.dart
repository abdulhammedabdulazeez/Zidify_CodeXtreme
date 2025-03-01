part of 'deposit_bloc.dart';

/// Base class for all deposit events
sealed class SaveBoxDepositEvent extends Equatable {
  const SaveBoxDepositEvent();

  @override
  List<Object?> get props => [];
}

/// Event for selecting a deposit option
final class OnSelectDepositOptionEvent extends SaveBoxDepositEvent {
  final FundingSourceGroup depositOption;

  const OnSelectDepositOptionEvent(this.depositOption);

  @override
  List<Object?> get props => [depositOption];
}

/// Event for selecting a list option within a deposit
final class OnHighlightListOptionEvent extends SaveBoxDepositEvent {
  final String depositType;
  final FundingSource selectedOption;

  const OnHighlightListOptionEvent(this.depositType, this.selectedOption);

  @override
  List<Object?> get props => [depositType, selectedOption];
}

/// Event to reset all selections
final class OnResetDepositSelectionEvent extends SaveBoxDepositEvent {
  const OnResetDepositSelectionEvent();
}
