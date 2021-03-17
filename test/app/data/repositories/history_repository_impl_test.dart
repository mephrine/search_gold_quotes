import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/history_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/repositories/history_repository_impl.dart';

class MockHistoryRemoteDataSource extends Mock
    implements HistoryRemoteDataSource {}

void main() {
  MockHistoryRemoteDataSource remoteDataSource;
  HistoryRepositoryImpl historyRepository;

  setUp(() {
    remoteDataSource = MockHistoryRemoteDataSource();
    historyRepository =
        HistoryRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('', () async {
    test('', () async {
      
    });
  });
}
