import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  VideoListModel videoList;
  setUp(() {
    videoList = VideoListModel(itemList: [
      VideoItemModel(title: 'Video1', subTitle: 'SubTitle1', linkURL: 'https://www.naver.com', imagePath: 'https://lottiefiles.com/10203-gold'),
      VideoItemModel(title: 'Video2', subTitle: 'SubTitle2', linkURL: 'https://www.daum.net', imagePath: 'https://lottiefiles.com/10204-gold'),
      VideoItemModel(title: 'Video3', subTitle: 'SubTitle3', linkURL: 'https://www.nate.com', imagePath: 'https://lottiefiles.com/10205-gold')
    ]);
  });

  group('VideoItemsModel 검증', () {
    test('VideoItemsModel ', () async {
      // arrange

      // act

      // assert
    });
  });
  group('VideoListModel 변환', () {

    test('Json Map이 VideoList Model로 리턴 되는지 확인', () async {
      // arrange
      final jsonMap = json.decode(fixture('video.json'));
      // act
      final result = VideoListModel.fromJson(jsonMap);
      // assert
      expect(result, videoList);
    });

    test('잘못된 JSON을 받았을 경우, 빈 데이터 모델 반환', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      // act
      final result = VideoListModel.fromJson(jsonMap);
      // assert
      expect(result, VideoListModel.empty());
    });
  });
}