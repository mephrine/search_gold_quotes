import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class VideoList extends Equatable {
  final List<VideoItem> itemList;

  VideoList({
    @required this.itemList
  });


  @override
  List<Object> get props => [itemList];

}

class VideoItem extends Equatable {
  final String title;
  final String subTitle;
  final String linkURL;
  final String imagePath;


  VideoItem({
    @required this.title,
    @required this.subTitle,
    @required this.linkURL,
    @required this.imagePath
  });

  @override
  List<Object> get props => [title, subTitle, linkURL, imagePath];

}