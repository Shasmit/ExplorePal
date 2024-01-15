part of 'place_bloc.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object> get props => [];
}

class PlaceDetailsInit extends PlaceDetailsEvent {}
