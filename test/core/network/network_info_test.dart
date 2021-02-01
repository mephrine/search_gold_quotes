import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImpl networkInfo;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should forward the call to DataConnectionChecker.hasConnection', () async {
      // arrange
      final testHasConnection = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => testHasConnection);
      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, testHasConnection);
    });
  });
}