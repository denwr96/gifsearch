import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionService {
  Future<bool> hasInternetAccess() async {
    return InternetConnection().hasInternetAccess;
  }

  Stream<InternetStatus> get onStatusChange {
    return InternetConnection().onStatusChange;
  }
}
