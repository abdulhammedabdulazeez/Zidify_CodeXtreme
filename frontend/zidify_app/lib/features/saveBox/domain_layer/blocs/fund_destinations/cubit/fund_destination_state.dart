part of 'fund_destination_cubit.dart';

@immutable
abstract class FundDestinationState extends Equatable {
  const FundDestinationState();

  @override
  List<Object> get props => [];
}

final class FundDestinationInitial extends FundDestinationState {}

final class FundDestinationLoadingState extends FundDestinationState {}

final class FundDestinationLoadedState extends FundDestinationState {
  final FundDestCollection fundDestinations;

  const FundDestinationLoadedState({required this.fundDestinations});

  @override
  List<Object> get props => [fundDestinations];
}

final class FundDestinationErrorState extends FundDestinationState {
  final String message;

  const FundDestinationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
