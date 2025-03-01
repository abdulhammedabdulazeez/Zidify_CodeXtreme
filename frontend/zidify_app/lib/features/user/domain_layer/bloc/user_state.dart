part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {}

// Loading state
class UserFetchLoadingState extends UserState {}

// Loaded state with user data
class UserFetchLoadedState extends UserState {
  final UserEntity user;
  const UserFetchLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

// Error state
class UserFetchErrorState extends UserState {
  final String error;
  const UserFetchErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
