import '../../domain/models/gif_item.dart';
import '../models/gif_item_dto.dart';
import '../services/giphy_api_service.dart';

class GifsRepository {
  final GiphyApiService apiService;

  GifsRepository({required this.apiService});

  Future<List<GifItem>> searchGifs({
    required String query,
    required int offset,
  }) async {
    final response = await apiService.searchGifs(
      query: query,
      offset: offset,
    );

    final data = response.data['data'] as List;

    return data.map((item) => GifItemDto.fromJson(item).toDomain()).toList();
  }
}
