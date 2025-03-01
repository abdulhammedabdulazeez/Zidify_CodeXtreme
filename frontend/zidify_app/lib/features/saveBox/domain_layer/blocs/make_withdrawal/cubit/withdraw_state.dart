part of 'withdraw_cubit.dart';

@immutable
abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object> get props => [];
}

final class WithdrawInitialState extends WithdrawState {}

final class WithdrawLoadingState extends WithdrawState {}

final class WithdrawSuccessState extends WithdrawState {}

final class WithdrawFailureState extends WithdrawState {
  final String message;

  const WithdrawFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
