import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/history_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/history_jewelry_model.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  HistoryRemoteDataSourceImpl dataSource;
  MockHttpClient httpClient;
  HistoryJewelryListModel historyList;
  Params defaultParams;

  setUp(() {
    httpClient = MockHttpClient();
    dataSource = HistoryRemoteDataSourceImpl(httpClient: httpClient);
    historyList = HistoryJewelryListModel(historyList: [
      HistoryJewelryModel(
          goldDate: "20210315",
          goldPrice: "195000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
      HistoryJewelryModel(
          goldDate: "20210313",
          goldPrice: "190000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
      HistoryJewelryModel(
          goldDate: "20210312",
          goldPrice: "180000",
          goldPriceType: "B",
          goldPurity: "C003001",
          jewelryType: "C002001",
          goldCurrency: "C001C001"),
    ]);
    defaultParams = Params(
        period: Period.daily,
        exchangeState: ExchangeState.buy,
        jewelryType: JewelryType.gold);
  });

  group('파라미터 확인', () {
    test('일일 골드 시세 구매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.daily,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold);

      final requestURL = historyURL + "/gold/buy/daily";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });

    test('월간 골드 시세 구매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.monthly,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold);

      final requestURL = historyURL + "/gold/buy/monthly";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });

    test('연간 골드 시세 구매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.yearly,
          exchangeState: ExchangeState.buy,
          jewelryType: JewelryType.gold);

      final requestURL = historyURL + "/gold/buy/yearly";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });

    test('일일 골드 시세 판매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.daily,
          exchangeState: ExchangeState.sell,
          jewelryType: JewelryType.gold);

      final requestURL = historyURL + "/gold/sell/daily";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });

    test('일일 다이아 시세 판매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.daily,
          exchangeState: ExchangeState.sell,
          jewelryType: JewelryType.diamond);

      final requestURL = historyURL + "/diamond/sell/daily";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });

    test('일일 백금 시세 판매 URL 확인', () async {
      // arrange
      final params = Params(
          period: Period.daily,
          exchangeState: ExchangeState.sell,
          jewelryType: JewelryType.platinum);

      final requestURL = historyURL + "/platinum/sell/daily";

      // assert
      expect(params.toRequestURL(historyURL), requestURL);
    });
  });

  group('서버에서 statusCode 200을 반환', () {
    test('서버에서 200이 반환되면 HisotryList를 가져와야한다.', () async {
      when(httpClient.get(any)).thenAnswer((_) async => Response(
          statusCode: 200,
          data: json.decode(fixture('gold_price_history_buy.json'))));

      final result = await dataSource.getHistoryData(defaultParams);

      expect(result, historyList);
    });

    test('서버에서 200이 반환되고 올바르지 않은 json이 반환된 경우 empty를 가져와야한다.', () async {
      when(httpClient.get(any)).thenAnswer((_) async => Response(
          statusCode: 200, data: json.decode(fixture('home_data.json'))));

      final result = await dataSource.getHistoryData(defaultParams);

      expect(result, HistoryJewelryListModel.empty());
    });

    test('서버에서 데이터가 null이 반환된 경우 ServerException이 발생해야한다.', () async {
      when(httpClient.get(any)).thenAnswer((_) async => null);

      final call = dataSource.getHistoryData(defaultParams);

      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('서버에서 statusCode 500을 반환', () {
    test('서버에서 500이 반환되면 ServerException 에러가 발생해야한다.', () async {
      when(httpClient.get(any))
          .thenAnswer((_) async => Response(statusCode: 500));

      final call = dataSource.getHistoryData(defaultParams);

      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });

    test('get 시 에러가 발생한다면, ServerException 에러로 치환되어야한다.', () async {
      when(httpClient.get(any)).thenThrow(throwsA(ServerException()));

      final call = dataSource.getHistoryData(defaultParams);

      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
