import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<void> checkInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl({this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker!.hasConnection;

  @override
  Future<bool> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
