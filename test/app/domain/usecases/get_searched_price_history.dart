import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_searched_price_history.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  GetSearchedPriceHistory usecase;
  MockHistoryRepository historyRepository;

  setUp(() {
    historyRepository = MockHistoryRepository();
    usecase = GetSearchedPriceHistory(repository: historyRepository);
  });

  test('History가 정상적으로 호출되면, HistoryJewelry가 반환되어야한다,', () {});
}
