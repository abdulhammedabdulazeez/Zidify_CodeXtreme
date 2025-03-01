part of 'withdraw_bloc.dart';

/// Base class for all Withdrawal events
sealed class SaveBoxWithdrawalEvent extends Equatable {
  const SaveBoxWithdrawalEvent();

  @override
  List<Object?> get props => [];
}

/// Event for selecting a Withdrawal option
final class OnSelectWithdrawalOptionEvent extends SaveBoxWithdrawalEvent {
  final FundDestGroup withdrawalOption;

  const OnSelectWithdrawalOptionEvent(this.withdrawalOption);

  @override
  List<Object?> get props => [withdrawalOption];
}

/// Event for selecting a list option within a Withdrawal
final class OnHighlightListOptionEvent extends SaveBoxWithdrawalEvent {
  final String withdrawalType;
  final FundDestination selectedOption;

  const OnHighlightListOptionEvent(this.withdrawalType, this.selectedOption);

  @override
  List<Object?> get props => [withdrawalType, selectedOption];
}

/// Event to reset all selections
final class OnResetWithdrawalSelectionEvent extends SaveBoxWithdrawalEvent {
  const OnResetWithdrawalSelectionEvent();
}
