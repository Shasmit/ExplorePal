import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/watchlist_entity.dart';
import '../../domain/repository/watchlist_repository.dart';
import '../dataSource/watchlist_remote_data_source.dart';

final watchListRemoteRepoProvider = Provider<IWatchListRepository>(
  (ref) => WatchListRemoteRepositoryImpl(
    watchListRemoteDataSource: ref.watch(watchListRemoteDataSourceProvider),
  ),
);

class WatchListRemoteRepositoryImpl implements IWatchListRepository {
  final WatchListRemoteDataSource watchListRemoteDataSource;

  WatchListRemoteRepositoryImpl({
    required this.watchListRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createWatchlist(
      int id, String title, String poster) {
    return watchListRemoteDataSource.createWatchlist(id, title, poster);
  }

  @override
  Future<Either<Failure, bool>> deleteWatchlist(String id) {
    return watchListRemoteDataSource.deleteWatchlist(id);
  }

  @override
  Future<Either<Failure, List<WatchListEntity>>> getWatchList() {
    return watchListRemoteDataSource.getWatchList();
  }
}
