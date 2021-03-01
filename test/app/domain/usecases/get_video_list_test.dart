import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';
import 'package:search_gold_quotes/app/domain/repositories/video_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';

class MockVideoRepository extends Mock implements VideoRepository {}

void main() {
  MockVideoRepository mockVideoRepository;
  GetVideoList getVideoList;
  setUp(() {
    mockVideoRepository = MockVideoRepository();
    getVideoList = GetVideoList(repository: mockVideoRepository);
  });

  group('비디오 리스트 정보 가져오기', () {
    final videoList = VideoList(itemList: [
      VideoItem(title: 'Video1', subTitle: 'SubTitle1', linkURL: 'https://www.naver.com', imagePath: 'https://lottiefiles.com/10203-gold'),
      VideoItem(title: 'Video2', subTitle: 'SubTitle2', linkURL: 'https://www.daum.net', imagePath: 'https://lottiefiles.com/10204-gold'),
      VideoItem(title: 'Video3', subTitle: 'SubTitle3', linkURL: 'https://www.nate.com', imagePath: 'https://lottiefiles.com/10205-gold')
    ]);

      test('VideoRepository에서 정상적으로 호출되었을 때, VideoList를 반환해야 한다.', () async {
        // arrange
        when(mockVideoRepository.getVideoList())
            .thenAnswer((_) async => Right(videoList));
        // act
        final result = await getVideoList.call(NoParams());

        // assert
        verify(mockVideoRepository.getVideoList());
        verifyNoMoreInteractions(mockVideoRepository);
        expect(result, Right(videoList));
       });

      test('VideoRepository에서 ServerFailure이 발생했을 때, ServerFailure가 반환되어야 한다.', () async {
        // arrange
        when(mockVideoRepository.getVideoList())
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final result = await getVideoList.call(NoParams());

        // assert
        expect(result, Left(ServerFailure()));
       });
  });
}