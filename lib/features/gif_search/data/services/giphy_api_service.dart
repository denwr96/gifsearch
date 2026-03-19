import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

class GiphyApiService {
  Future<Response> searchGifs({
    required String query,
    required int offset,
  }) async {
    final response = await DioClient.dio.get(
      '/gifs/search',
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        'q': query,
        'limit': ApiConstants.limit,
        'offset': offset,
      },
    );

    return response;
  }
}
