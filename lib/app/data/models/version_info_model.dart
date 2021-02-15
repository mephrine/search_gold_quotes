import 'dart:convert';

import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:meta/meta.dart';

class VersionInfoModel extends VersionInfo {
  VersionInfoModel({
    @required String latestVersion,
    @required String forceUpdate
  }): super(latestVersion: latestVersion, forceUpdate: forceUpdate);


  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    return VersionInfoModel(
        latestVersion: json["latestVersion"],
        forceUpdate: json["forceUpdate"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latestVersion": latestVersion,
      "forceUpdate": forceUpdate
    };
  }
}