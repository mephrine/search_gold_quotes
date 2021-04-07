import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/bloc/video_bloc.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';
import 'package:search_gold_quotes/core/error/error_messages.dart';

class MockGetVideoList extends Mock implements GetVideoList {}

void main() {
  MockGetVideoList usecase;
  VideoBloc bloc;
  setUp(() {
    usecase = MockGetVideoList();
    bloc = VideoBloc(videoListUsecase: usecase);
  });

  test('초기 상태값 확인', () async {
    // assert
    expect(bloc.state, Empty());
  });

  group('Video Bloc Test', () {
    final videoList = VideoList(itemList: [
      VideoItem(
          title: 'Video1',
          subTitle: 'SubTitle1',
          linkURL: 'https://www.naver.com',
          imagePath: 'https://lottiefiles.com/10203-gold'),
      VideoItem(
          title: 'Video2',
          subTitle: 'SubTitle2',
          linkURL: 'https://www.daum.net',
          imagePath: 'https://lottiefiles.com/10204-gold'),
      VideoItem(
          title: 'Video3',
          subTitle: 'SubTitle3',
          linkURL: 'https://www.nate.com',
          imagePath: 'https://lottiefiles.com/10205-gold')
    ]);

    test('GetVideoList usecase시 데이터 가져오는 것이 성공했을 때, VideoListModel 을 반환한다.',
        () async {
      // arrange
      when(usecase(any)).thenAnswer((_) async => Right(videoList));
      // act
      bloc.add(GetVideoListOnLoaded());
      await untilCalled(usecase(any));

      // assert
      verify(usecase(NoParams()));
    });

    test('GetVideoList usecase 성공 했을 때, 상태 변화는 [Loading, Loaded] 로 변화되어야 한다.',
        () async {
      // arrange
      when(usecase(any)).thenAnswer((_) async => Right(videoList));
      // act
      bloc.add(GetVideoListOnLoaded());

      // assert
      final expected = [Loading(), Loaded(videoList: videoList)];

      expectLater(bloc, emitsInOrder(expected));
    });

    test('GetVideoList usecase 에러가 발생했을 때, 상태 변화는 [Loading, Error]로 변화되어야 한다.',
        () async {
      // arrange
      when(usecase(any)).thenAnswer((_) async => Left(ServerFailure()));
      // act
      bloc.add(GetVideoListOnLoaded());

      // assert
      final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];

      expectLater(bloc, emitsInOrder(expected));
    });
  });
}
