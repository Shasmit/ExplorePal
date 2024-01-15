import 'package:dartz/dartz.dart';
import 'package:exploree_pal/core/failure/failure.dart';
import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<PlacesDetails>>> getPlaceDetails();
}
