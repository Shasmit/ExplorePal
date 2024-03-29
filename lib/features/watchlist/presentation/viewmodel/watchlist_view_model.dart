import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/watchlist_use_case.dart';
import '../state/watchlist_state.dart';

final watchListViewModelProvider =
    StateNotifierProvider<WatchListViewModel, WatchListState>(
  (ref) => WatchListViewModel(
    watchListUseCase: ref.watch(watchListUseCaseProvider),
  ),
);

class WatchListViewModel extends StateNotifier<WatchListState> {
  final WatchListUseCase watchListUseCase;

  WatchListViewModel({
    required this.watchListUseCase,
  }) : super(WatchListState.initial()) {
    getWatchList();
  }

  Future<void> getWatchList() async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.getWatchList();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (watchList) => state = state.copyWith(
        isLoading: false,
        watchList: watchList,
        error: null,
      ),
    );
  }

  createWatchlist(int id, String title, String poster) async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.createWatchlist(id, title, poster);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  deleteWatchlist(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.deleteWatchlist(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }
}
