import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/history_jewelry_model.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';
import 'package:search_gold_quotes/core/values/constants.dart';

abstract class HistoryRemoteDataSource {
  Future<HistoryJewelryListModel> getHistoryData(Params params);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final Dio httpClient;

  HistoryRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<HistoryJewelryListModel> getHistoryData(Params params) async {
    try {
      final requestURL = params.toRequestURL(Constants.historyURL);
      final response = await httpClient.get(requestURL);

      if (response.statusCode == 200) {
        return HistoryJewelryListModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (exception) {
      throw ServerException();
    }
  }
}
