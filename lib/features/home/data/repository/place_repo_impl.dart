import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exploree_pal/core/failure/failure.dart';
import 'package:exploree_pal/features/home/data/dataSource/places_data_soure.dart';
import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';
import 'package:exploree_pal/features/home/domain/repository/places_repository.dart';

class PlaceDetailsRepoImpl implements PlacesRepository {
  @override
  Future<Either<Failure, List<PlacesDetails>>> getPlaceDetails() async {
    try {
      final response = await getPlaceLocalDetails();
      return Right(response);
    } on DioException catch (e) {
      print('ssssssssssss');
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
