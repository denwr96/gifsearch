import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/gifs_repository.dart';
import '../../data/services/giphy_api_service.dart';

import '../controllers/gif_search_controller.dart';
import '../controllers/gif_search_state.dart';

final giphyApiServiceProvider = Provider<GiphyApiService>((ref) {
  return GiphyApiService();
});

final gifsRepositoryProvider = Provider<GifsRepository>((ref) {
  return GifsRepository(
    apiService: ref.read(giphyApiServiceProvider),
  );
});

final gifSearchControllerProvider =
    NotifierProvider<GifSearchController, GifSearchState>(
      GifSearchController.new,
    );
