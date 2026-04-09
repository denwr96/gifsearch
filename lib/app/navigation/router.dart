import 'package:go_router/go_router.dart';
import 'app_routes.dart';

import '../../features/gif_search/domain/models/gif_item.dart';
import '../../features/gif_search/presentation/screens/gif_detail_screen.dart';
import '../../features/gif_search/presentation/screens/gif_search_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const GifSearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.details,
      builder: (context, state) {
        final gif = state.extra as GifItem;
        return GifDetailScreen(gif: gif);
      },
    ),
  ],
);
