import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitialLoading()) {
    on<GetDetailData>((event, emit) {
      
    });
  }
}
