import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/gifs_repository.dart';
import '../providers/gif_search_providers.dart';
import 'gif_search_state.dart';

class GifSearchController extends Notifier<GifSearchState> {
  late final GifsRepository _repository;

  @override
  GifSearchState build() {
    _repository = ref.read(gifsRepositoryProvider);
    return const GifSearchState();
  }

  Future<void> searchGifs(String query) async {
    if (query.trim().isEmpty) {
      state = const GifSearchState();
      return;
    }

    state = state.copyWith(
      query: query,
      gifs: [],
      isLoading: true,
      isLoadingMore: false,
      errorMessage: null,
      hasMore: true,
      offset: 0,
    );

    try {
      final gifs = await _repository.searchGifs(
        query: query,
        offset: 0,
      );

      state = state.copyWith(
        gifs: gifs,
        isLoading: false,
        hasMore: gifs.isNotEmpty,
        offset: gifs.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load GIFs',
      );
    }
  }

  Future<void> loadMoreGifs() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }

    try {
      state = state.copyWith(
        isLoadingMore: true,
        errorMessage: null,
      );

      final newGifs = await _repository.searchGifs(
        query: state.query,
        offset: state.offset,
      );

      state = state.copyWith(
        gifs: [...state.gifs, ...newGifs],
        isLoadingMore: false,
        hasMore: newGifs.isNotEmpty,
        offset: state.offset + newGifs.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more GIFs',
      );
    }
  }
}
