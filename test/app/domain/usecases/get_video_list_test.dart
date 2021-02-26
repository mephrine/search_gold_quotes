import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/domain/repositories/video_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';

class MockVideoRepository extends Mock implements VideoRepository {}

void main() {
  MockVideoRepository mockVideoRepository;
  GetVideoList getVideoList;
  setUp(() {
    mockVideoRepository = MockVideoRepository();
    getVideoList = GetVideoList(repository: mockVideoRepository);
  });
}