import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

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