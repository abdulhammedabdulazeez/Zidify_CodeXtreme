import 'dart:async';

import 'package:zidify_app/features/auth/data_layer/models/signin_req_params.dart';
import 'package:zidify_app/features/auth/data_layer/models/signup_req_params.dart';
import 'package:zidify_app/features/auth/domain_layer/usecases/signin.dart';
import 'package:zidify_app/features/auth/domain_layer/usecases/signup.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase? signupUseCase;
  final SigninUseCase? signinUseCase;

  AuthBloc({this.signupUseCase, this.signinUseCase}) : super(AuthInitial()) {
    on<OnSignupSubmitAuthEvent>(onSignupSubmitAuthEvent);
    on<OnLoginButtonClickedAuthEvent>(onLoginButtonClickedAuthEvent);
  }

  FutureOr<void> onSignupSubmitAuthEvent(
      OnSignupSubmitAuthEvent event, Emitter<AuthState> emit) async {
    emit(SignupLoadingState());

    final signUpParams = SignupReqParams(
      email: event.email,
      firstName: event.firstName,
      lastName: event.lastName,
      password: event.password,
      phoneNumber: event.phoneNumber,
    );

    // await Future.delayed(const Duration(seconds: 3));

    try {
      Either result = await signupUseCase!.call(param: signUpParams);
      // Either result = await sl<SignupUseCase>().call(param: signUpParams);

      result.fold((failure) {
        emit(SignupFailureState(error: failure));
        // print(failure);
      }, (data) {
        emit(SignupSucessState());
      });
    } catch (e) {
      emit(SignupFailureState(error: e.toString()));
      // print(e.toString());
    }
  }

  FutureOr<void> onLoginButtonClickedAuthEvent(
      OnLoginButtonClickedAuthEvent event, Emitter<AuthState> emit) async {
    emit(SigninLoadingState());

    final signInParams = SignInReqParams(
      email: event.email,
      password: event.password,
    );

    try {
      Either result = await signinUseCase!.call(param: signInParams);

      result.fold((failure) {
        emit(SigninFailureState(error: failure));
      }, (data) {
        emit(SigninSucessState());
      });
    } catch (e) {
      emit(SigninFailureState(error: e.toString()));
      // print(e.toString());
    }
  }
}
