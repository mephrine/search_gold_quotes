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
  List<HistoryJewelry> historyList;
  ;

  setUp(() {
    historyRepository = MockHistoryRepository();
    useCase = GetSearchedPriceHistory(repository: historyRepository);
    historyList = [
      HistoryJewelry(
          variationState: "U",
          variationPrice: "10000",
          date: "2021-03-16",
          price: "210000",
          goldCurrency: "C001C001"),
      HistoryJewelry(
          variationState: "D",
          variationPrice: "5000",
          date: "2021-03-15",
          price: "200000",
          goldCurrency: "C001C001"),
      HistoryJewelry(
          variationState: "U",
          variationPrice: "3000",
          date: "2021-03-14",
          price: "195000",
          goldCurrency: "C001C001")
    ];
  });

  test('History가 정상적으로 호출되면, HistoryJewelry가 반환되어야한다,', () async {
    // arrange
    when(historyRepository.getHistoryData())
        .thenAnswer((_) async => Right(historyList));

    // act
    final result = await useCase(
        Params(period: 'daily', exchangeState: 'buy', jewelryType: 'gold'));

    // assert
    verify(historyRepository.getHistoryData());
    expect(result, result);
    verifyNoMoreInteractions(historyRepository);
  });
}
