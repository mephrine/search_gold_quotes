import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';

class VideoListModel extends VideoList {
  factory VideoListModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      final Map<String, dynamic> data = jsonMap['data'];
      Iterable iterable = data['youtubeList'];
      final videoList = List<VideoItemModel>.from(iterable.map((data) => VideoItemModel.fromJson(data)));
      return VideoListModel(itemList: videoList);
    } catch(e) {
      return VideoListModel.empty();
    }
  }

  VideoListModel({@required List<VideoItemModel> itemList}): super(itemList: itemList);

  factory VideoListModel.empty() {
    return VideoListModel(itemList: []);
  }
}


class VideoItemModel extends VideoItem {
  factory VideoItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return VideoItemModel(title: jsonMap['youtubeTitle'],
        subTitle: jsonMap['youtubeSubTitle'],
        linkURL: jsonMap['youtubeUrl'],
        imagePath: jsonMap['thumbImageUrl']);
  }

  VideoItemModel({
    @required String title,
    @required String subTitle,
    @required String linkURL,
    @required String imagePath
  }): super(title: title, subTitle: subTitle, linkURL: linkURL, imagePath: imagePath);
}

