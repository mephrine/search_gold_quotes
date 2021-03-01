import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/video_items.dart';

class VideoListModel extends VideoList {

  factory VideoListModel.fromJson(Map<String, dynamic> jsonMap) {
    Iterable iterable = jsonMap['videoList'];
    final videoList = List<VideoItemModel>.from(iterable.map((jsonMap) => VideoItemModel.fromJson(jsonMap)));
    return VideoListModel(itemList: videoList);
  }

  VideoListModel({@required List<VideoItemModel> itemList}): super(itemList: itemList);
}


class VideoItemModel extends VideoItem {


  factory VideoItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return VideoItemModel(title: jsonMap['title'],
        subTitle: jsonMap['subTitle'],
        linkURL: jsonMap['linkURL'],
        imagePath: jsonMap['imagePath']);
  }

  VideoItemModel({
    @required String title,
    @required String subTitle,
    @required String linkURL,
    @required String imagePath
  }): super(title: title, subTitle: subTitle, linkURL: linkURL, imagePath: imagePath);
}

