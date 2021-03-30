import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/history_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/history_jewelry_model.dart';
import 'package:search_gold_quotes/app/data/repositories/history_repository_impl.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';

import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class MockHistoryRemoteDataSource extends Mock
    implements HistoryRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockHistoryRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  HistoryRepositoryImpl historyRepository;
  HistoryJewelryListModel historyList;

  setUp(() {
    remoteDataSource = MockHistoryRemoteDataSource();
    networkInfo = MockNetworkInfo();
    historyRepository = HistoryRepositoryImpl(
        remoteDataSource: remoteDataSource, networkInfo: networkInfo);
    historyList = HistoryJewelryListModel(historyList: [
      HistoryJewelryModel(
          goldDate: "2021-03-16",
          goldPrice: "195000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
      HistoryJewelryModel(
          goldDate: "2021-03-15",
          goldPrice: "190000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
      HistoryJewelryModel(
          goldDate: "2021-03-14",
          goldPrice: "180000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
    ]);
  });

  group('network is connected', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('네트워크가 연결된 경우 networkInfo는 true를 반환해야한다.', () async {
      await historyRepository.getHistoryData(any);

      verify(networkInfo.isConnected);
    });

    test(
        'repository에서 remoteDataSource 호출 시 성공한 경우 historyList와 동일한 데이터를 보여준다.',
        () async {
      // arrange
      when(remoteDataSource.getHistoryData(any))
          .thenAnswer((_) async => historyList);

      // act
      final result = await historyRepository.getHistoryData(any);

      // assert
      expect(result, Right(historyList));
    });
  });

  group('network is disconnectd', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('네트워크가 연결되지 않은 경우, ServerFailure를 반환해야한다.', () async {
      // when(remoteDataSource.getHistoryData());

      final result = await historyRepository.getHistoryData(Params(
          period: Period.daily,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold));

      expect(result, Left(ServerFailure()));
    });
  });
}
