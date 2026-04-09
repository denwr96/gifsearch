import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/gif_search/domain/models/gif_item.dart';
import 'app_routes.dart';

class AppNavigator {
  static void openGifDetails(BuildContext context, GifItem gif) {
    context.push(AppRoutes.details, extra: gif);
  }
}
