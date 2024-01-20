import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../auth/data/model/auth_api_model.dart';
import '../../domain/entity/watchlist_entity.dart';
import '../dto/get_watchlist_dto.dart';
import '../model/watchlist_api_model.dart';

final watchListRemoteDataSourceProvider = Provider(
  (ref) => WatchListRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    watchListApiModel: ref.read(watchListApiModelProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class WatchListRemoteDataSource {
  final Dio dio;
  final WatchListApiModel watchListApiModel;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  WatchListRemoteDataSource({
    required this.dio,
    required this.watchListApiModel,
    required this.authApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<WatchListEntity>>> getWatchList() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      var response = await dio.get(
        ApiEndpoints.getWatchlist,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetWatchListDTO getWatchListDTO =
            GetWatchListDTO.fromJson(response.data);

        return Right(
          watchListApiModel.toEntityList(getWatchListDTO.data),
        );
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> createWatchlist(
      int id, String title, String poster) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String watchlistEndpoint = ApiEndpoints.createWatchlist;
      var response = await dio.post(
        watchlistEndpoint,
        data: {
          'id': id.toString(),
          'title': title,
          'poster': poster,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteWatchlist(String id) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String watchlistEndpoint = '${ApiEndpoints.deleteWatchlist}/$id';
      var response = await dio.delete(
        watchlistEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
