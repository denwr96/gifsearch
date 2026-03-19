import '../../domain/models/gif_item.dart';

class GifSearchState {
  final List<GifItem> gifs;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final bool hasMore;
  final String query;
  final int offset;

  const GifSearchState({
    this.gifs = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.hasMore = true,
    this.query = '',
    this.offset = 0,
  });

  GifSearchState copyWith({
    List<GifItem>? gifs,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool? hasMore,
    String? query,
    int? offset,
  }) {
    return GifSearchState(
      gifs: gifs ?? this.gifs,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
      offset: offset ?? this.offset,
    );
  }
}
