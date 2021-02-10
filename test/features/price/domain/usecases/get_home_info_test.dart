import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/features/price/domain/entities/gold.dart';
import 'package:search_gold_quotes/features/price/domain/entities/home_data.dart';
import 'package:search_gold_quotes/features/price/domain/usecases/get_home_data.dart';

class MockGetHomeInfo extends Mock implements GetHomeInfo {}

void main() {
  MockGetHomeInfo mockGetHomeInfo;

  setUp(() {
    mockGetHomeInfo = MockGetHomeInfo();


    group('', () {
      final gold = Gold()
      final homeInfo = HomeData(famousQuotes: 'Gold is God', referenceSiteName: "https://www.naver.com", goldList: );

    });
  });
}