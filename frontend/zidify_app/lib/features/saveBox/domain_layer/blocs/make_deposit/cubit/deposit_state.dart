part of 'deposit_cubit.dart';

@immutable
abstract class DepositState extends Equatable {
  const DepositState();

  @override
  List<Object> get props => [];
}

final class DepositInitialState extends DepositState {}

final class DepositLoadingState extends DepositState {}

final class DepositSuccessState extends DepositState {}

final class DepositFailureState extends DepositState {
  final String message;

  const DepositFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
