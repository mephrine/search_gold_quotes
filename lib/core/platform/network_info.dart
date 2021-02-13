import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get connectionListener;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async => await connectivity.checkConnectivity() != ConnectivityResult.none;

  @override
  Stream<ConnectivityResult> get connectionListener => connectivity.onConnectivityChanged;
}