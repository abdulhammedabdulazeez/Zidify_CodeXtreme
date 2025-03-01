import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_fundDestinations.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'fund_destination_state.dart';

class FundDestinationCubit extends Cubit<FundDestinationState> {
  FundDestinationCubit() : super(FundDestinationInitial());

  Future<void> getFundDestinations() async {
    emit(FundDestinationLoadingState());
    try {
      Either<Exception, FundDestCollection> result =
          await sl<FetchFundDestUseCase>().call();
      result.fold((error) {
        emit(FundDestinationErrorState(message: error.toString()));
      }, (fundDestinations) {
        emit(FundDestinationLoadedState(fundDestinations: fundDestinations));
      });
    } catch (e) {
      emit(FundDestinationErrorState(message: e.toString()));
    }
  }
}
