import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../../core/network/internet_connection_service.dart';

final internetConnectionServiceProvider = Provider<InternetConnectionService>((
  ref,
) {
  return InternetConnectionService();
});

final internetStatusProvider = StreamProvider<InternetStatus>((ref) {
  final service = ref.read(internetConnectionServiceProvider);
  return service.onStatusChange;
});
