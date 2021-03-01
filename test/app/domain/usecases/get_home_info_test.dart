import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/app/domain/repositories/home_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_home_data.dart';
import 'package:search_gold_quotes/core/usecases/NoParams.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetHomeInfo usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetHomeInfo(homeRepository: mockHomeRepository);
  });

  group('GetHomeInfo', () {
    final gold = HomeGold(date: '2021-02-10', day: '오늘', price: '100000');
    final homeInfo = HomeData(famousQuotes: 'Gold is God', referenceSiteName: "https://www.naver.com", goldList: [gold]);

    test('should get price, referenceSite and famousQuotes for Information at home tab from the repository', () async {
      // arrange
      when(mockHomeRepository.getHomeData())
          .thenAnswer((_) async => Right(homeInfo));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, equals(Right(homeInfo)));
      verify(mockHomeRepository.getHomeData());
      verifyNoMoreInteractions(mockHomeRepository);
    });
  });
}