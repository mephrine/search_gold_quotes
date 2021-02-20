import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VersionInfo extends Equatable {
  final String latestVersion;
  final String forceUpdate;

  VersionInfo({
    @required this.latestVersion,
    @required this.forceUpdate
  });

  @override
  List<Object> get props => [latestVersion, forceUpdate];

}