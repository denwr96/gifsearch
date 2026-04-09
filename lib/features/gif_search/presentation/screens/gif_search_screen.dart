import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../providers/gif_search_providers.dart';
import '../providers/network_providers.dart';

import '../widgets/search_results_view.dart';
import '../widgets/search_text_field.dart';
import '../widgets/offline_view.dart';

class GifSearchScreen extends ConsumerStatefulWidget {
  const GifSearchScreen({super.key});

  @override
  ConsumerState<GifSearchScreen> createState() => _GifSearchScreenState();
}

class _GifSearchScreenState extends ConsumerState<GifSearchScreen> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      _loadMoreIfOnline();
    }
  }

  Future<void> _performSearch(String query) async {
    final internetService = ref.read(internetConnectionServiceProvider);
    final hasInternet = await internetService.hasInternetAccess();

    if (!hasInternet) return;

    await ref.read(gifSearchControllerProvider.notifier).searchGifs(query);
  }

  Future<void> _loadMoreIfOnline() async {
    final internetService = ref.read(internetConnectionServiceProvider);
    final hasInternet = await internetService.hasInternetAccess();

    if (!hasInternet) return;

    await ref.read(gifSearchControllerProvider.notifier).loadMoreGifs();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(gifSearchControllerProvider);
    final internetStatusAsync = ref.watch(internetStatusProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIF Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchTextField(
              controller: _searchController,
              onChanged: (value) {
                _debounce?.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _performSearch(value);
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: internetStatusAsync.when(
                data: (status) {
                  if (status == InternetStatus.disconnected) {
                    return OfflineView(
                      onRetry: () {
                        _performSearch(searchState.query);
                      },
                    );
                  }

                  return SearchResultsView(
                    searchState: searchState,
                    scrollController: _scrollController,
                    onRetry: () {
                      ref
                          .read(gifSearchControllerProvider.notifier)
                          .searchGifs(searchState.query);
                    },
                  );
                },
                loading: () {
                  return SearchResultsView(
                    searchState: searchState,
                    scrollController: _scrollController,
                    onRetry: () {
                      ref
                          .read(gifSearchControllerProvider.notifier)
                          .searchGifs(searchState.query);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return SearchResultsView(
                    searchState: searchState,
                    scrollController: _scrollController,
                    onRetry: () {
                      ref
                          .read(gifSearchControllerProvider.notifier)
                          .searchGifs(searchState.query);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
