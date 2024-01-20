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

  Future<Either<Failure, bool>> createWatchlist(int id) {
    return watchListRepository.createWatchlist(id);
  }

  Future<Either<Failure, bool>> deleteWatchlist(int id) {
    return watchListRepository.deleteWatchlist(id);
  }

  Future<Either<Failure, List<WatchListEntity>>> getWatchList() {
    return watchListRepository.getWatchList();
  }
}
