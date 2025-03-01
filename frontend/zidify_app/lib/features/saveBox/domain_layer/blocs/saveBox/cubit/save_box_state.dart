part of 'save_box_cubit.dart';

abstract class SaveBoxState extends Equatable {
  const SaveBoxState();

  @override
  List<Object> get props => [];
}

final class SaveBoxInitial extends SaveBoxState {}

final class SaveBoxLoadingState extends SaveBoxState {}

final class SaveBoxLoadedState extends SaveBoxState {
  final SaveboxEntity saveBox;

  const SaveBoxLoadedState({required this.saveBox});

  @override
  List<Object> get props => [saveBox];
}

final class SaveBoxErrorState extends SaveBoxState {
  final String message;

  const SaveBoxErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
