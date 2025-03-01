import 'dart:async';

import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:zidify_app/features/user/domain_layer/usecases/get_user.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<OnFetchUserEvent>(onFetchUserEvent);
  }

  FutureOr<void> onFetchUserEvent(
      OnFetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserFetchLoadingState());

    try {
      Either<Exception, UserEntity> result =
          await sl<FetchUserUseCase>().call();

      result.fold((failure) {
        emit(UserFetchErrorState(error: failure.toString()));
        print('Wrong response below');
        print(failure);
      }, (user) {
        emit(UserFetchLoadedState(user: user));
      });
    } catch (e) {
      emit(UserFetchErrorState(error: e.toString()));
      print('Catch response below');
      print(e.toString());
    }
  }
}
