import 'package:flutter/material.dart';

import '../../domain/models/gif_item.dart';

class GifDetailScreen extends StatelessWidget {
  final GifItem gif;

  const GifDetailScreen({
    super.key,
    required this.gif,
  });

  @override
  Widget build(BuildContext context) {
    final title = gif.title.isEmpty ? 'Untitled GIF' : gif.title;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GIF Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  gif.originalUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const ColoredBox(
                      color: Colors.black12,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(
                      color: Colors.black12,
                      child: Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text('ID: ${gif.id}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
