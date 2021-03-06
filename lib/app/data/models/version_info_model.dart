
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';

class VersionInfoModel extends VersionInfo {
  VersionInfoModel({
    @required String appVersion,
    @required String forceUpdate
  }): super(latestVersion: appVersion, forceUpdate: forceUpdate);


  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    return VersionInfoModel(
        appVersion: json["app_version"],
        forceUpdate: json["forceUpdate"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "app_version": latestVersion,
      "forceUpdate": forceUpdate
    };
  }
}