import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  GetSearchedPriceHistory useCase;
  MockHistoryRepository historyRepository;
  HistoryJewelryList historyList;

  setUp(() {
    historyRepository = MockHistoryRepository();
    useCase = GetSearchedPriceHistory(repository: historyRepository);

    historyList = HistoryJewelryList(historyList: [
      HistoryJewelry(
          date: "20210315", price: "195000", goldCurrency: "C001C001"),
      HistoryJewelry(
          date: "20210313", price: "190000", goldCurrency: "C001C001"),
      HistoryJewelry(
          date: "20210312", price: "180000", goldCurrency: "C001C001")
    ]);
  });

  test('History가 정상적으로 호출되면, HistoryJewelry가 반환되어야한다,', () async {
    // arrange
    when(historyRepository.getHistoryData(any))
        .thenAnswer((_) async => Right(historyList));

    // act
    final params = Params(
        period: Period.daily,
        exchangeState: ExchangeState.buy,
        jewelryType: JewelryType.gold);
    final result = await useCase(params);

    // assert
    verify(historyRepository.getHistoryData(params));
    expect(result, result);
    verifyNoMoreInteractions(historyRepository);
  });
}
