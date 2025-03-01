part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnFetchUserEvent extends UserEvent {}

class OnRefreshUserEvent extends UserEvent {}
