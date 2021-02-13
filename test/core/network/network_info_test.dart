import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class MockDataConnectivity extends Mock implements Connectivity {}

void main() {
  MockDataConnectivity mockDataConnectionChecker;
  NetworkInfoImpl networkInfo;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectivity();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should forward the call to Connectivity.checkConnectivity in cellular network', () async {
      // arrange
      final testHasConnection = Future.value(ConnectivityResult.mobile);
      when(mockDataConnectionChecker.checkConnectivity())
          .thenAnswer((_) => testHasConnection);
      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(mockDataConnectionChecker.checkConnectivity());
      expect(result, true);
    });

    test(
        'should forward the call to Connectivity.checkConnectivity none', () async {
      // arrange
      final testHasConnection = Future.value(ConnectivityResult.none);
      when(mockDataConnectionChecker.checkConnectivity())
          .thenAnswer((_) => testHasConnection);
      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(mockDataConnectionChecker.checkConnectivity());
      expect(result, false);
    });
  });
}