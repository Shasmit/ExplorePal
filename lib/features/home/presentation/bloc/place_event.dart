part of 'place_bloc.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object> get props => [];
}

class PlaceDetailsInit extends PlaceDetailsEvent {}

class PlaceDetailsLoad extends PlaceDetailsEvent {
  final void Function() loaded;

  const PlaceDetailsLoad({required this.loaded});

  @override
  List<Object> get props => [loaded];
}
