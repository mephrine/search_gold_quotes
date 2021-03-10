import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  bool get validateResponseData => this?.statusCode == 200 && this?.data != null;
}