import 'package:search_gold_quotes/app/data/models/video_items_model.dart';

abstract class VideoRemoteDataSource {
  Future<VideoListModel> getVideoList();
}

class VideoRemoteDataSourceImpl extends VideoRemoteDataSource {
  @override
  Future<VideoListModel> getVideoList() async {
    return null;
  }

}