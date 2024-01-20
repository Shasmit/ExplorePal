import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/watchlist_entity.dart';
import '../repository/watchlist_repository.dart';

final watchListUseCaseProvider = Provider<WatchListUseCase>(
  (ref) => WatchListUseCase(
    watchListRepository: ref.watch(watchListRepositoryProvider),
  ),
);

class WatchListUseCase {
  final IWatchListRepository watchListRepository;

  WatchListUseCase({
    required this.watchListRepository,
  });

  Future<Either<Failure, bool>> createWatchlist(
      int id, String title, String poster) {
    return watchListRepository.createWatchlist(id, title, poster);
  }

  Future<Either<Failure, bool>> deleteWatchlist(String id) {
    return watchListRepository.deleteWatchlist(id);
  }

  Future<Either<Failure, List<WatchListEntity>>> getWatchList() {
    return watchListRepository.getWatchList();
  }
}
