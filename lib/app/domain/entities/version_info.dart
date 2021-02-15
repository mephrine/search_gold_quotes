import 'package:meta/meta.dart';

class VersionInfo {
  final String latestVersion;
  final String forceUpdate;

  VersionInfo({
    @required this.latestVersion,
    @required this.forceUpdate
  });
}