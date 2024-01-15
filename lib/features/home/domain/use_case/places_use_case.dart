import 'package:dartz/dartz.dart';
import 'package:exploree_pal/config/constants/usecase_interface.dart';
import 'package:exploree_pal/core/failure/failure.dart';
import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';

import '../repository/places_repository.dart';

class GetPlaceDetailsUseCase extends UseCase<List<PlacesDetails>, NoParams> {
  final PlacesRepository placesRepository;

  GetPlaceDetailsUseCase({required this.placesRepository});

  @override
  Future<Either<Failure, List<PlacesDetails>>> call(NoParams params) async {
    return await placesRepository.getPlaceDetails();
  }
}
