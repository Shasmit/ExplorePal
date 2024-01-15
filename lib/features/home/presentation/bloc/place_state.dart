part of 'place_bloc.dart';

abstract class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();
  @override
  List<Object> get props => [];
}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsError extends PlaceDetailsState {
  final String message;
  final SnackBar snackBar;
  const PlaceDetailsError({required this.message, required this.snackBar});
}

class PlaceDetailsLoaded extends PlaceDetailsState {
  final List<PlacesDetails> placesDetails;

  const PlaceDetailsLoaded({required this.placesDetails});

  @override
  List<Object> get props => [placesDetails];
}
