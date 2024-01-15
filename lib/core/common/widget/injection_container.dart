import 'package:exploree_pal/features/home/domain/use_case/places_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../../features/home/data/repository/place_repo_impl.dart';
import '../../../features/home/domain/repository/places_repository.dart';
import '../../../features/home/presentation/bloc/place_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  injectPlaces();
}

void injectPlaces() {
  sl.registerFactory<PlaceDetailsBloc>(
    () => PlaceDetailsBloc(
      getPlaceDetailsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => GetPlaceDetailsUseCase(placesRepository: sl()));

  sl.registerLazySingleton<PlacesRepository>(
    () => PlaceDetailsRepoImpl(),
  );
}
