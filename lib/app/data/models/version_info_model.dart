
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';

class VersionInfoModel extends VersionInfo {
  VersionInfoModel({
    @required String appVersion,
    @required String forceUpdate
  }): super(latestVersion: appVersion, forceUpdate: forceUpdate);


  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic> dataObject = json["data"];
      return VersionInfoModel(
          appVersion: dataObject["app_version"],
          forceUpdate: dataObject["forceUpdate"]
      );
    } catch(e) {
      return VersionInfoModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "app_version": latestVersion,
        "forceUpdate": forceUpdate
      }
    };
  }

  factory VersionInfoModel.empty() {
    return VersionInfoModel(appVersion: "", forceUpdate: "");
  }
}