import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';
import 'package:recipe/feature/details/domain/usecase/get_detail_usecase.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailUsecase getDetailUseCase;
  DetailBloc({required this.getDetailUseCase}) : super(DetailInitialLoading()) {
    on<GetDetailData>((event, emit) async {
      final result = await getDetailUseCase.getfoodDetail(id: event.detailId);
      result.fold(
        (failer) {
          emit(DetailFailedData(failerHandler: failer));
        },
        (success) {
          emit(DetailHaveData(detailEntite: success.data));
        },
      );
    });
  }
}
