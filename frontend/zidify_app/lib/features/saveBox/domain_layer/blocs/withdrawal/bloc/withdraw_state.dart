part of 'withdraw_bloc.dart';

/// Base class for all Withdrawal states
sealed class SaveBoxWithdrawalState extends Equatable {
  const SaveBoxWithdrawalState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any selection
final class WithdrawalInitialState extends SaveBoxWithdrawalState {}

/// State when a Withdrawal option is selected
final class WithdrawalOptionSelectedState extends SaveBoxWithdrawalState {
  final String activeWithdrawalType;
  final FundDestination highlightedItem;

  const WithdrawalOptionSelectedState({
    required this.activeWithdrawalType,
    required this.highlightedItem,
  });

  WithdrawalOptionSelectedState copyWith({
    String? activeWithdrawalType,
    FundDestination? highlightedItem,
  }) {
    return WithdrawalOptionSelectedState(
      activeWithdrawalType: activeWithdrawalType ?? this.activeWithdrawalType,
      highlightedItem: highlightedItem ?? this.highlightedItem,
    );
  }

  @override
  List<Object?> get props => [activeWithdrawalType, highlightedItem];
}
