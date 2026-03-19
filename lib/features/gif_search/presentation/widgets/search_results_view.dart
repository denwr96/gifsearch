import 'package:flutter/material.dart';

import '../controllers/gif_search_state.dart';
import 'gif_tile.dart';

class SearchResultsView extends StatelessWidget {
  final GifSearchState searchState;
  final ScrollController scrollController;
  final VoidCallback onRetry;

  const SearchResultsView({
    super.key,
    required this.searchState,
    required this.scrollController,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (searchState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (searchState.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                searchState.errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (searchState.gifs.isEmpty) {
      final hasQuery = searchState.query.trim().isNotEmpty;

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.gif_box_outlined,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                hasQuery ? 'No GIFs found' : 'Start typing to search GIFs',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(bottom: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: searchState.gifs.length,
                itemBuilder: (context, index) {
                  final gif = searchState.gifs[index];
                  return GifTile(gif: gif);
                },
              ),
            ),
            if (searchState.isLoadingMore)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
