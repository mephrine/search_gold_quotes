
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/data/datasources/video_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/app/data/repositories/video_repository_impl.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';

class MockVideoRemoteDataSource extends Mock implements VideoRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockVideoRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  VideoRepositoryImpl repository;
  setUp(() {
    remoteDataSource = MockVideoRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = VideoRepositoryImpl(dataSource: remoteDataSource, networkInfo: networkInfo);
  });

  group('네트워크 연결 O', () {
    VideoListModel videoList;
    setUp((){
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);

      videoList = VideoListModel(itemList: [
        VideoItemModel(title: 'Video1', subTitle: 'SubTitle1', linkURL: 'https://www.naver.com', imagePath: 'https://lottiefiles.com/10203-gold'),
        VideoItemModel(title: 'Video2', subTitle: 'SubTitle2', linkURL: 'https://www.daum.net', imagePath: 'https://lottiefiles.com/10204-gold'),
        VideoItemModel(title: 'Video3', subTitle: 'SubTitle3', linkURL: 'https://www.nate.com', imagePath: 'https://lottiefiles.com/10205-gold')
      ]);
    });
    test('정상적으로 동작할 경우, RemoteDataSource 에서 VideoListModel 을 반환 받는다. ', () async {
        // arrange
        when(remoteDataSource.getVideoList())
            .thenAnswer((_) async => videoList);
        // act
        final result = await repository.getVideoList();

        // assert
      expect(result, Right(videoList));
     });

    test('네트워크 에러가 발생해서 Server Failure 반환', () async {
        // arrange
        when(remoteDataSource.getVideoList())
            .thenThrow(ServerException());
        // act
        final result = await repository.getVideoList();
        // assert
        expect(result, Left(ServerFailure()));
     });

    test('파싱 에러가 발생했을 때, Parse Failure 반환', () async {
        // arrange
        when(remoteDataSource.getVideoList())
            .thenThrow(ParseException());
        // act
        final result = await repository.getVideoList();

        // assert
        expect(result, Left(ParseFailure()));
     });
  });

  group('네트워크 연결 X', () {
    setUp((){
      when(networkInfo.isConnected)
          .thenAnswer((_) async => false);
    });
    test('RemoteDataSource 에 접근 하지 않고 ServerFailure 반', () async {
        // arrange
        // act
        final result = await repository.getVideoList();
        // assert
      expect(result, Left(ServerFailure()));
     });
  });
}