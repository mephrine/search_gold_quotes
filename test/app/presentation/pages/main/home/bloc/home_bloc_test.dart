import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_home_data.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home/home_bloc.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class MockGetHomeInfoUsecase extends Mock implements GetHomeInfo {}

void main() {
  MockGetHomeInfoUsecase usecase;
  HomeBloc bloc;

  setUp(() {
    usecase = MockGetHomeInfoUsecase();
    bloc = HomeBloc(homeInfo: usecase);
  });

  test('GetHomeData 초기 상태 확인', () async {
    // assert
    expect(bloc.initialState, Empty());
  });

  group('HomeData 상태', () {
    final homeData = HomeData(famousQuotes: 'Gold is God', referenceSiteName: "https://www.naver.com", goldList: [
        HomeGold(date: '2021-02-10', day: '오늘', price: '100000')
    ]);
    test('GetHomeData 이벤트 발생 시, GetHomeInfo usecase가 실행된다.', () async {
        // act
      bloc.add(GetHomeData());
      await untilCalled(usecase(any));

      // assert
      verify(usecase(NoParams()));
     });

    test('데이터를 성공적으로 가져왔을 때, [Loading, Loaded] 를 방출한다.', () async {
      // arrange
      when(usecase(any))
          .thenAnswer((_) async => Right(homeData));

      // act
      bloc.add(GetHomeData());

      // assert
      final expected = [
        Loading(),
        Loaded(homeData: homeData)
      ];
      expectLater(bloc, emitsInOrder(expected));
    });

    test('데이터를 가져오는게 실패했을 때, [Loading, Error] 를 방출한다.', () async {
      // arrange
      when(usecase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      bloc.add(GetHomeData());

      // assert
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expected));
    });
  });
}