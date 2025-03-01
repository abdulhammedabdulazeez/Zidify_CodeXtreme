part of 'funding_sources_cubit.dart';

@immutable
abstract class FundingSourcesState extends Equatable {
  const FundingSourcesState();

  @override
  List<Object> get props => [];
}

final class FundingSourcesInitial extends FundingSourcesState {}

final class FundingSourcesLoadingState extends FundingSourcesState {}

final class FundingSourcesLoadedState extends FundingSourcesState {
  final FundingSourceCollection fundingSources;

  const FundingSourcesLoadedState({required this.fundingSources});

  @override
  List<Object> get props => [fundingSources];
}

final class FundingSourcesErrorState extends FundingSourcesState {
  final String message;

  const FundingSourcesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
