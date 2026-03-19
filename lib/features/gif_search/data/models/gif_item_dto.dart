import '../../domain/models/gif_item.dart';

class GifItemDto {
  final String id;
  final String title;
  final String previewUrl;
  final String originalUrl;

  const GifItemDto({
    required this.id,
    required this.title,
    required this.previewUrl,
    required this.originalUrl,
  });

  factory GifItemDto.fromJson(Map<String, dynamic> json) {
    return GifItemDto(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      previewUrl: json['images']?['fixed_width']?['url'] ?? '',
      originalUrl: json['images']?['original']?['url'] ?? '',
    );
  }

  GifItem toDomain() {
    return GifItem(
      id: id,
      title: title,
      previewUrl: previewUrl,
      originalUrl: originalUrl,
    );
  }
}
