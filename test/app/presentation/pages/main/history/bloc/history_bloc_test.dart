import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/history/bloc/history_bloc.dart';
import 'package:search_gold_quotes/core/error/failures.dart';

class MockGetSearchedPriceHistory extends Mock
    implements GetSearchedPriceHistory {}

void main() {
  MockGetSearchedPriceHistory useCase;
  HistoryBloc bloc;
  HistoryJewelryList historyList;

  setUp(() {
    useCase = MockGetSearchedPriceHistory();
    bloc = HistoryBloc(getHistoryUseCase: useCase);

    historyList = HistoryJewelryList(historyList: [
      HistoryJewelry(
          date: "20210315", price: "195000", goldCurrency: "C001C001"),
      HistoryJewelry(
          date: "20210313", price: "190000", goldCurrency: "C001C001"),
      HistoryJewelry(
          date: "20210312", price: "180000", goldCurrency: "C001C001")
    ]);
  });

  test('첫 상태값은 Empty여야 한다.', () async {
    expect(bloc.initialState, Empty());
  });

  test('UseCase가 호출되는지 확인', () async {
    when(useCase(any)).thenAnswer((_) async => Right(historyList));

    bloc.add(GetSearchedHistoryList(
        period: Period.daily,
        exchangeState: ExchangeState.buy,
        jewelryType: JewelryType.gold));
    await untilCalled(useCase(any));

    verify(useCase(Params(
        period: Period.daily,
        exchangeState: ExchangeState.buy,
        jewelryType: JewelryType.gold)));
  });

  group('상태값 체크', () {
    test('UseCase를 호출하고 정상적인 결과가 온 경우, Loading -> Loaded로 상태가 변경되어야 한다.',
        () async {
      when(useCase(any)).thenAnswer((_) async => Right(historyList));

      bloc.add(GetSearchedHistoryList(
          period: Period.daily,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold));

      final expected = [
        Loading(),
        Loaded(
            historyList: historyList,
            chartList: bloc.chartList(historyList),
            exchangeState: ExchangeState.buy,
            period: Period.daily,
            sortedPriceList: bloc.chartPriceList(historyList))
      ];

      expectLater(bloc, emitsInOrder(expected));
    });

    test('UseCase를 호출하고 에러가 발생한 경우, Loading -> Error로 상태가 변경되어야 한다.', () async {
      when(useCase(any)).thenAnswer((_) async => Left(ServerFailure()));

      bloc.add(GetSearchedHistoryList(
          period: Period.daily,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold));

      final expected = [
        Loading(),
        Error(errorMessage: bloc.failureToErrorMessage(ServerFailure()))
      ];

      expectLater(bloc, emitsInOrder(expected));
    });
  });
}
