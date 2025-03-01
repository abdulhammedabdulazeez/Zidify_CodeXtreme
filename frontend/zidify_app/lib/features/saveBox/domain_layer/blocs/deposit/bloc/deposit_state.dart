part of 'deposit_bloc.dart';

/// Base class for all deposit states
sealed class SaveBoxDepositState extends Equatable {
  const SaveBoxDepositState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any selection
final class DepositInitialState extends SaveBoxDepositState {}

/// State when a deposit option is selected
final class DepositOptionSelectedState extends SaveBoxDepositState {
  final String activeDepositType;
  final FundingSource highlightedItem;

  const DepositOptionSelectedState({
    required this.activeDepositType,
    required this.highlightedItem,
  });

  DepositOptionSelectedState copyWith({
    String? activeDepositType,
    FundingSource? highlightedItem,
  }) {
    return DepositOptionSelectedState(
      activeDepositType: activeDepositType ?? this.activeDepositType,
      highlightedItem: highlightedItem ?? this.highlightedItem,
    );
  }

  @override
  List<Object?> get props => [activeDepositType, highlightedItem];
}