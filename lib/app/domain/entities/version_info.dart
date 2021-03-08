import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VersionInfo extends Equatable {
  final String latestVersion;
  final int appVersionSeq;

  VersionInfo({
    @required this.latestVersion,
    @required this.appVersionSeq
  });

  @override
  List<Object> get props => [latestVersion, appVersionSeq];

}