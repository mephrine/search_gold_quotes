import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/video_items_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/extensions/dio_response.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

abstract class VideoRemoteDataSource {
  Future<VideoListModel> getVideoList();
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio httpClient;

  VideoRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<VideoListModel> getVideoList() async {
    try {
      final response = await httpClient.get(videoListURL);
      if (response.validateResponseData) {
        try {
          return VideoListModel.fromJson(response.data);
        } catch (exception) {
          throw ParseException();
        }
      } else {
        throw ServerException();
      }
    } catch (exception) {
      throw ServerException();
    }
  }

//   final testData = """
//   {
//   "data": {
//     "videoList": [
//       {
//         "title": "Video1",
//         "subTitle": "SubTitle1",
//         "linkURL": "https://www.naver.com",
//         "imagePath": "https://lottiefiles.com/10203-gold"
//       },
//       {
//         "title": "Video2",
//         "subTitle": "SubTitle2",
//         "linkURL": "https://www.daum.net",
//         "imagePath": "https://lottiefiles.com/10204-gold"
//       },
//       {
//         "title": "Video3",
//         "subTitle": "SubTitle3",
//         "linkURL": "https://www.nate.com",
//         "imagePath": "https://lottiefiles.com/10205-gold"
//       }
//     ]
//   }
// }
//   """;
}
