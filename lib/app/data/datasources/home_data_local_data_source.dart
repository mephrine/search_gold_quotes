
import 'package:search_gold_quotes/app/data/models/home_data_model.dart';

abstract class  HomeDataLocalDataSource {
  Future<HomeDataModel> getLastHomeData();
}