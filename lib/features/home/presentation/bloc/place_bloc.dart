import 'package:equatable/equatable.dart';
import 'package:exploree_pal/features/home/domain/use_case/places_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/usecase_interface.dart';
import '../../domain/entity/places_entity.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final GetPlaceDetailsUseCase getPlaceDetailsUseCase;

  PlaceDetailsBloc({required this.getPlaceDetailsUseCase})
      : super(PlaceDetailsInitial()) {
    on<PlaceDetailsInit>(
      (event, emit) async {
        emit(PlaceDetailsLoading());
        final result = await getPlaceDetailsUseCase(NoParams());

        result.fold(
          (failure) {
            emit(
              PlaceDetailsError(
                message: failure.error,
                snackBar: const SnackBar(
                  content: Text('Could not load match player details'),
                ),
              ),
            );
          },
          (r) {
            emit(
              PlaceDetailsLoaded(placesDetails: r),
            );
          },
        );
      },
    );
  }
}
