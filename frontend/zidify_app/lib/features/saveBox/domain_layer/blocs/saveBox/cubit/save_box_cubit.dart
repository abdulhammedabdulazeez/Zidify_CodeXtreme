import 'dart:async';

import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_savebox.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'save_box_state.dart';

class SaveBoxCubit extends Cubit<SaveBoxState> {
  SaveBoxCubit() : super(SaveBoxInitial());

  FutureOr<void> getSaveBox() async {
    emit(SaveBoxLoadingState());
    try {
      Either<Exception, SaveboxEntity> result =
          await sl<FetchSaveBoxUseCase>().call();

      result.fold((error) {
        emit(SaveBoxErrorState(message: error.toString()));
      }, (saveBox) {
        emit(SaveBoxLoadedState(saveBox: saveBox));
      });
    } catch (e) {
      emit(SaveBoxErrorState(message: e.toString()));
    }
  }
}
