part of 'selectedarea_cubit.dart';

abstract class SelectedareaState extends Equatable {
  final AreaEntities? areaEntities;

  const SelectedareaState({this.areaEntities});

  @override
  List<Object?> get props => [areaEntities];
}

class SelectedareaInitial extends SelectedareaState {
  const SelectedareaInitial({super.areaEntities});
}

class SelectedAreaState extends SelectedareaState {
  const SelectedAreaState({required super.areaEntities});
}
