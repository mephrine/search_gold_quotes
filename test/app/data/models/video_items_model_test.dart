import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  VideoItemListModel videoList;
  setUp(() {
    videoList = VideoItemListModel(itemList: [
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
      final result = VideoItemListModel.fromJson(jsonMap);
      // assert
      expect(result, videoList);
    });
  });
}