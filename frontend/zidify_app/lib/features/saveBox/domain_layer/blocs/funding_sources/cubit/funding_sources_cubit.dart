import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/usecases/get_fundingSources.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'funding_sources_state.dart';

class FundingSourcesCubit extends Cubit<FundingSourcesState> {
  FundingSourcesCubit() : super(FundingSourcesInitial());

  Future<void> getFundingSources() async {
    emit(FundingSourcesLoadingState());
    try {
      Either<Exception, FundingSourceCollection> result =
          await sl<FetchFundingSourcesUseCase>().call();
      result.fold((error) {
        emit(FundingSourcesErrorState(message: error.toString()));
      }, (fundingSources) {
        emit(FundingSourcesLoadedState(fundingSources: fundingSources));
      });
    } catch (e) {
      emit(FundingSourcesErrorState(message: e.toString()));
    }
  }
}
