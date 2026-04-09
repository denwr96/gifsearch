import 'package:flutter/material.dart';
import '../../../../app/navigation/app_navigator.dart';
import '../../domain/models/gif_item.dart';

class GifTile extends StatelessWidget {
  final GifItem gif;

  const GifTile({
    super.key,
    required this.gif,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.openGifDetails(context, gif);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GridTile(
          footer: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Text(
              gif.title.isEmpty ? 'Untitled GIF' : gif.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          child: Image.network(
            gif.previewUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return const ColoredBox(
                color: Colors.black12,
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(
                color: Colors.black12,
                child: Center(
                  child: Icon(Icons.broken_image),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
