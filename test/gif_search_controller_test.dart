import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gifsearch/features/gif_search/domain/models/gif_item.dart';
import 'package:gifsearch/features/gif_search/data/repositories/gifs_repository.dart';
import 'package:gifsearch/features/gif_search/presentation/providers/gif_search_providers.dart';

class MockGifsRepository extends Mock implements GifsRepository {}

void main() {
  late MockGifsRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockGifsRepository();

    container = ProviderContainer(
      overrides: [
        gifsRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('searchGifs with empty query resets state', () async {
    final controller = container.read(gifSearchControllerProvider.notifier);

    await controller.searchGifs('');

    final state = container.read(gifSearchControllerProvider);

    expect(state.gifs, isEmpty);
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
    expect(state.errorMessage, null);
    expect(state.hasMore, true);
    expect(state.query, '');
    expect(state.offset, 0);
  });

  test('searchGifs updates state with loaded gifs', () async {
    final gifs = [
      const GifItem(
        id: '1',
        title: 'Cat GIF',
        previewUrl: 'https://preview-url.com',
        originalUrl: 'https://original-url.com',
      ),
    ];

    when(
      () => mockRepository.searchGifs(
        query: 'cat',
        offset: 0,
      ),
    ).thenAnswer((_) async => gifs);

    final controller = container.read(gifSearchControllerProvider.notifier);

    await controller.searchGifs('cat');

    final state = container.read(gifSearchControllerProvider);

    expect(state.gifs, gifs);
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
    expect(state.errorMessage, null);
    expect(state.query, 'cat');
    expect(state.offset, 1);
    expect(state.hasMore, true);
  });

  test('loadMoreGifs appends new gifs to existing list', () async {
    final firstPage = [
      const GifItem(
        id: '1',
        title: 'First GIF',
        previewUrl: 'https://preview-1.com',
        originalUrl: 'https://original-1.com',
      ),
    ];

    final secondPage = [
      const GifItem(
        id: '2',
        title: 'Second GIF',
        previewUrl: 'https://preview-2.com',
        originalUrl: 'https://original-2.com',
      ),
    ];

    when(
      () => mockRepository.searchGifs(
        query: 'cat',
        offset: 0,
      ),
    ).thenAnswer((_) async => firstPage);

    when(
      () => mockRepository.searchGifs(
        query: 'cat',
        offset: 1,
      ),
    ).thenAnswer((_) async => secondPage);

    final controller = container.read(gifSearchControllerProvider.notifier);

    await controller.searchGifs('cat');
    await controller.loadMoreGifs();

    final state = container.read(gifSearchControllerProvider);

    expect(state.gifs.length, 2);
    expect(state.gifs[0].id, '1');
    expect(state.gifs[1].id, '2');
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
    expect(state.errorMessage, null);
    expect(state.offset, 2);
    expect(state.hasMore, true);
  });

  test('searchGifs sets errorMessage when repository throws', () async {
    when(
      () => mockRepository.searchGifs(
        query: 'cat',
        offset: 0,
      ),
    ).thenThrow(Exception('Network error'));

    final controller = container.read(gifSearchControllerProvider.notifier);

    await controller.searchGifs('cat');

    final state = container.read(gifSearchControllerProvider);

    expect(state.gifs, isEmpty);
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
    expect(state.errorMessage, 'Failed to load GIFs');
    expect(state.query, 'cat');
    expect(state.offset, 0);
  });
}
