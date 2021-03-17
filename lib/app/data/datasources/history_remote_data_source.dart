import '../models/jewelry_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<JewelryModel>> getHistoryData();
}
