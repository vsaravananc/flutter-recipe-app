import 'package:bloc/bloc.dart';

class PagecurrentindexCubit extends Cubit<int> {
  PagecurrentindexCubit() : super(0);

  void setIndex(int index) => emit(index);

}
