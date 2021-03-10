
import 'package:json_annotation/json_annotation.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class Data {
  final VersionInfoModel versionInfoModel;
  Data({@required this.versionInfoModel});

  // factory Data.fromJson(Map<String, dynamic> json) =>
  //     _$DataFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$DataToJson(this);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      versionInfoModel: json['versionInfoModel'] == null
          ? null
          : VersionInfoModel.fromJson(
          json['versionInfoModel'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
    'versionInfoModel': instance.versionInfoModel,
  };

}