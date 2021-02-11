import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/features/price/domain/entities/gold.dart';
import 'package:search_gold_quotes/features/price/domain/entities/home_data.dart';
import 'package:search_gold_quotes/features/price/domain/usecases/get_home_data.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetHomeInfo getHomeInfo;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    getHomeInfo = GetHomeInfo();
    mockHomeRepository = MockHomeRepository();


    group('GetHomeInfo', () {
      final gold = Gold(date: '2021-02-10', day: '오늘', price: '100000');
      final homeInfo = HomeData(famousQuotes: 'Gold is God', referenceSiteName: "https://www.naver.com", goldList: [gold]);

      // when(mockGetHomeInfo.)
    });
  });
}