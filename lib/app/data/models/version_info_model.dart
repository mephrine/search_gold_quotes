import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';

@JsonSerializable()
class VersionInfoModel extends VersionInfo {
  VersionInfoModel({@required String appVersion, @required int appVersionSeq})
      : super(latestVersion: appVersion, appVersionSeq: appVersionSeq);

  // factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
  //   return VersionInfoModel(
  //     appVersionSeq: json['appVersionSeq'] as int,
  //   );
  // }

  // Map<String, dynamic> _$VersionInfoModelToJson(VersionInfoModel instance) =>
  //     <String, dynamic>{
  //       'appVersionSeq': instance.appVersionSeq,
  //     };

  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    try {
      final dynamic dataObject = json["data"];
      return VersionInfoModel(
          appVersion: dataObject["version"],
          appVersionSeq: dataObject["appVersionSeq"]);
    } catch (e) {
      return VersionInfoModel.empty();
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "data": {"version": latestVersion, "appVersionSeq": appVersionSeq}
    };
  }

  factory VersionInfoModel.empty() {
    return VersionInfoModel(appVersion: "", appVersionSeq: 1);
  }
}
